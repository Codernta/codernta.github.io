import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// App theme configuring dark mode palette and typography.
class AppTheme {
  const AppTheme._();

  static ThemeData get darkTheme {
    final baseTextTheme = ThemeData.dark().textTheme;
    final textTheme = GoogleFonts.spaceGroteskTextTheme(baseTextTheme).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.flutterCyan,
        onPrimary: AppColors.background,
        surface: AppColors.card,
        onSurface: AppColors.textPrimary,
        outline: AppColors.border,
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      textTheme: textTheme,
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),
    );
  }
}
