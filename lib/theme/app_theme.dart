import 'package:flutter/material.dart';

class AppTheme {
  static const Color seedColor = Color(0xFF6750A4);
  static const Color background = Color(0xFFFFFBFE);
  static const Color surfaceContainer = Color(0xFFF3EDF7);

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        surface: background,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      cardTheme: const CardThemeData(
        color: surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28.0)),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
        ),
      ),
    );
  }
}
