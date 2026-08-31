import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;

import '../models/transaction.dart';

class TransactionService {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _firestore.collection('users').doc(uid).collection('transactions');

  Stream<List<Transaction>> stream(String uid) {
    return _col(uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map((s) => s.docs
            .map((d) => Transaction.fromMap(d.id, d.data()))
            .toList());
  }

  Future<void> add(String uid, Transaction tx) async {
    await _col(uid).add(tx.toMap());
  }

  Future<void> update(String uid, Transaction tx) async {
    await _col(uid).doc(tx.id).set(tx.toMap(), SetOptions(merge: true));
  }

  Future<void> delete(String uid, String id) async {
    await _col(uid).doc(id).delete();
  }

  /// Tambah transaksi contoh (sekali, untuk pengguna baru).
  Future<void> seedSample(String uid) async {
    final now = Timestamp.now();
    final d = now.toDate();
    final monthStart = Timestamp.fromDate(DateTime(d.year, d.month, 1));
    await _col(uid).add({
      'uid': uid,
      'type': 'income',
      'amount': 2500000,
      'category': 'income_salary',
      'note': 'Gaji',
      'date': monthStart,
      'createdAt': now,
    });
    await _col(uid).add({
      'uid': uid,
      'type': 'expense',
      'amount': 45000,
      'category': 'expense_food',
      'note': 'Makan siang',
      'date': now,
      'createdAt': now,
    });
  }
}