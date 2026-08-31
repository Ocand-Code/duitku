import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/transaction.dart';
import '../theme/app_theme.dart';

/// Satu baris transaksi dalam list.
class TransactionTile extends StatelessWidget {
  final Transaction tx;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TransactionTile({
    super.key,
    required this.tx,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final c =
        DefaultCategories.byId(tx.category) ?? DefaultCategories.expense.first;
    final color = tx.isIncome ? AppTheme.income : AppTheme.expense;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: const StadiumBorder(),
      child: ListTile(
        dense: true,
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: c.color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(c.emoji, style: const TextStyle(fontSize: 20)),
        ),
        title: Text(
          c.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          tx.note.isEmpty ? '' : tx.note,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${tx.isIncome ? '+' : '-'}${AppTheme.formatRupiah(tx.amount)}',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            if (onDelete != null) ...[
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 22),
                color: Colors.red,
                onPressed: onDelete,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class TransactionDayHeader extends StatelessWidget {
  final String label;

  const TransactionDayHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const EmptyState({
    super.key,
    this.emoji = '💸',
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}