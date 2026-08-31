import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';

import '../models/transaction.dart';
import '../services/transaction_service.dart';
import '../utils/date_util.dart';
import '../widgets/summary_card.dart';
import '../widgets/transaction_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _svc = TransactionService();
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    _month = DateTime(DateTime.now().year, DateTime.now().month);
  }

  void _goMonth(int delta) {
    setState(() {
      _month = DateTime(_month.year, _month.month + delta);
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DuitKu'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF6B7280)),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: StreamBuilder<List<Transaction>>(
        stream: _svc.stream(uid),
        builder: (context, snap) {
          final txs = snap.data ?? [];

          final income = txs
              .where((t) => t.isIncome && _sameMonth(t.date, _month))
              .fold<double>(0, (s, t) => s + t.amount);
          final expense = txs
              .where((t) => !t.isIncome && _sameMonth(t.date, _month))
              .fold<double>(0, (s, t) => s + t.amount);
          final balance = income - expense;

          final groups = <String, List<Transaction>>{};
          for (final t in txs) {
            final d = t.date.toDate();
            final key = DateUtil.groupKey(d);
            (groups[key] ??= []).add(t);
          }
          final dayKeys = groups.keys.toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SummaryCard(
                    balance: balance,
                    income: income,
                    expense: expense,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: _monthBar()),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              if (txs.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyState(
                    emoji: '💸',
                    title: 'Belum ada transaksi',
                    subtitle: 'Tekan tombol + untuk catat transaksi pertama',
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final key = dayKeys[i ~/ 2];
                      if (i.isEven) {
                        return TransactionDayHeader(
                          label: DateUtil.groupLabel(groups[key]!.first.date.toDate()),
                        );
                      }
                      final list = groups[key]!;
                      final tx = list[(i ~/ 2) % list.length];
                      return TransactionTile(
                        tx: tx,
                        onDelete: () => _svc.delete(uid, tx.id),
                      );
                    },
                    childCount: dayKeys.length * 2,
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  bool _sameMonth(Timestamp ts, DateTime m) {
    final d = ts.toDate();
    return d.year == m.year && d.month == m.month;
  }

  Widget _monthBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Color(0xFF6B7280)),
            onPressed: () => _goMonth(-1),
            visualDensity: VisualDensity.compact,
          ),
          Text(
            DateUtil.formatMonthYear(_month),
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Color(0xFF6B7280)),
            onPressed: () => _goMonth(1),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}