import 'package:intl/intl.dart';

class DateUtil {
  DateUtil._();

  static String formatFull(DateTime d) =>
      '${d.day} ${_month(d.month)} ${d.year}';

  static String formatShort(DateTime d) => '${d.day} ${_month(d.month)}';

  static String formatMonthYear(DateTime d) =>
      '${_month(d.month)} ${d.year}';

  static String todayLabel() {
    final now = DateTime.now();
    return 'Hari ini';
  }

  static String monthLabel(int m) => _month(m);

  static String _month(int m) {
    const names = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    return names[m];
  }

  static String groupKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day}';

  static String groupLabel(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(d.year, d.month, d.day);
    final diff = today.difference(day).inDays;
    if (diff == 0) return 'Hari ini';
    if (diff == 1) return 'Kemarin';
    return '${d.day} ${_month(d.month)} ${d.year}';
  }

  static String dayName(int w) {
    const names = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    return names[w - 1];
  }
}