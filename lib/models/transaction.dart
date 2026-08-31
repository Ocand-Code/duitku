import 'package:cloud_firestore/cloud_firestore.dart';

/// Satu transaksi keuangan.
class Transaction {
  final String id;
  final String uid;
  final String type; // 'income' | 'expense'
  final double amount;
  final String category;
  final String note;
  final Timestamp date;
  final Timestamp createdAt;

  const Transaction({
    required this.id,
    required this.uid,
    required this.type,
    required this.amount,
    required this.category,
    required this.note,
    required this.date,
    required this.createdAt,
  });

  bool get isIncome => type == 'income';

  factory Transaction.fromMap(String id, Map<String, dynamic> map) {
    return Transaction(
      id: id,
      uid: map['uid'] as String? ?? '',
      type: map['type'] as String? ?? 'expense',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      category: map['category'] as String? ?? 'expense_other',
      note: map['note'] as String? ?? '',
      date: map['date'] as Timestamp? ?? Timestamp.now(),
      createdAt: map['createdAt'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'type': type,
      'amount': amount,
      'category': category,
      'note': note,
      'date': date,
      'createdAt': createdAt,
    };
  }
}