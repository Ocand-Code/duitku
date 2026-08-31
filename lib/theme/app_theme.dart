import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _seed = Color(0xFF0F9D58);
  static const Color _income = Color(0xFF059669);
  static const Color _expense = Color(0xFFEF4444);

  static Color get income => _income;
  static Color get expense => _expense;

  static const _light = ColorScheme.light(
    primary: _seed,
  );

  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: _light,
    scaffoldBackgroundColor: const Color(0xFFF7F9F8),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: const StadiumBorder(),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 4,
      shape: StadiumBorder(),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 4),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.w700,
        color: Color(0xFF1F2937),
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF1F2937),
      ),
      bodyMedium: TextStyle(color: Color(0xFF6B7280)),
      bodySmall: TextStyle(color: Color(0xFF9CA3AF)),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE5E7EB),
      thickness: 1,
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(const StadiumBorder()),
      ),
    ),
  );

  static String formatRupiah(double amount) {
    final negative = amount < 0;
    final abs = amount.abs();
    final s = abs.toStringAsFixed(0);
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      buf.write(s[i]);
      final remaining = s.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        buf.write('.');
      }
    }
    return '${negative ? '-' : ''}Rp ${buf.toString()}';
  }
}

extension ColorX on num {
  Color get color => Color((this * 255).round());
}
