import 'package:flutter/material.dart';

/// Kategori transaksi statik.
class TxCategory {
  final String id;
  final String name;
  final String emoji;
  final Color color;
  final bool isIncome;

  const TxCategory(
    this.id,
    this.name,
    this.emoji,
    this.color, {
    this.isIncome = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TxCategory && other.id == id);

  @override
  int get hashCode => id.hashCode;
}

/// Daftar kategori default (dipakai di seluruh app).
class DefaultCategories {
  static const income = [
    TxCategory('income_salary', 'Gaji', '💼', Color(0xFF4F46E5), isIncome: true),
    TxCategory('income_side', 'Sampingan', '💼', Color(0xFF7C3AED), isIncome: true),
    TxCategory('income_bonus', 'Bonus', '🎁', Color(0xFF059669), isIncome: true),
    TxCategory('income_sale', 'Jual-Beli', '💰', Color(0xFF0EA5E9), isIncome: true),
    TxCategory('income_gift', 'Hadiah', '🎁', Color(0xFFD97706), isIncome: true),
    TxCategory('income_other', 'Lainnya', '📦', Color(0xFF6B7280), isIncome: true),
  ];

  static const expense = [
    TxCategory('expense_food', 'Makanan', '🍔', Color(0xFFEF4444)),
    TxCategory('expense_drink', 'Minuman', '☕', Color(0xFFD97706)),
    TxCategory('expense_transport', 'Transport', '🚗', Color(0xFF2563EB)),
    TxCategory('expense_shop', 'Belanja', '🛒', Color(0xFF7C3AED)),
    TxCategory('expense_bill', 'Tagihan', '🧾', Color(0xFF059669)),
    TxCategory('expense_entertainment', 'Hiburan', '🎮', Color(0xFF7C3AED)),
    TxCategory('expense_health', 'Kesehatan', '🏥', Color(0xFF10B981)),
    TxCategory('expense_other', 'Lainnya', '📦', Color(0xFF6B7280)),
  ];

  static TxCategory? byId(String id) {
    for (final c in [...income, ...expense]) {
      if (c.id == id) return c;
    }
    return null;
  }

  static List<TxCategory> forType(bool isIncome) =>
      isIncome ? income : expense;
}