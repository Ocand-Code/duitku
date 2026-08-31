import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category.dart';
import '../models/transaction.dart';
import '../services/transaction_service.dart';
import '../theme/app_theme.dart';
import '../widgets/category_chip.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  final _svc = TransactionService();

  bool _isIncome = false;
  String _category = DefaultCategories.expense.first.id;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _toggle(bool income) {
    setState(() {
      _isIncome = income;
      final list = DefaultCategories.forType(income);
      if (!list.any((c) => c.id == _category)) {
        _category = list.first.id;
      }
    });
  }

  Future<void> _save() async {
    final amount = double.tryParse(_amountCtrl.text.replaceAll('.', '').replaceAll(',', '.')) ?? 0.0;
    if (amount <= 0) return;

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final now = Timestamp.now();
    await _svc.add(
      uid,
      Transaction(
        id: '',
        uid: uid,
        type: _isIncome ? 'income' : 'expense',
        amount: amount,
        category: _category,
        note: _noteCtrl.text.trim(),
        date: now,
        createdAt: now,
      ),
    );

    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Transaksi ${_isIncome ? 'pemasukan' : 'pengeluaran'} disimpan',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = DefaultCategories.forType(_isIncome);
    final accent = _isIncome ? AppTheme.income : AppTheme.expense;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF6B7280)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Transaksi Baru'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('Pemasukan')),
                ButtonSegment(value: false, label: Text('Pengeluaran')),
              ],
              selected: {_isIncome},
              onSelectionChanged: (s) => _toggle(s.first),
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: accent,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _amountCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              cursorColor: const Color(0xFF0F9D58),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0F9D58), width: 2),
                ),
                prefixText: 'Rp ',
                prefixStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteCtrl,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0F9D58), width: 2),
                ),
                hintText: 'Catatan (opsional)',
                prefixIcon: Icon(Icons.note_alt_outlined, color: Color(0xFF9CA3AF), size: 20),
              ),
            ),
            const SizedBox(height: 18),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kategori',
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
              ),
            ),
            const SizedBox(height: 8),
            CategoryGrid(
              categories: categories,
              selectedId: _category,
              onSelected: (id) => setState(() => _category = id),
            ),
            const Spacer(),
            FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: const StadiumBorder(),
                backgroundColor: accent,
              ),
              child: const Text('Simpan'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}