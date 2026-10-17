import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography helpers referencing Google Fonts.
class AppTypography {
  const AppTypography._();

  // Display Font: Syne
  static TextStyle displayBold({
    double fontSize = 32,
    Color color = AppColors.textPrimary,
    double letterSpacing = -0.5,
  }) {
    return GoogleFonts.syne(
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle displayExtraBold({
    double fontSize = 48,
    Color color = AppColors.textPrimary,
    double letterSpacing = -1.0,
  }) {
    return GoogleFonts.syne(
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  // Sans Font: Space Grotesk
  static TextStyle sans({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColors.textPrimary,
    double? height,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  static TextStyle sansMedium({
    double fontSize = 16,
    Color color = AppColors.textPrimary,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle sansBold({
    double fontSize = 20,
    Color color = AppColors.textPrimary,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  // Monospace Font: JetBrains Mono
  static TextStyle mono({
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColors.textSecondary,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle monoBold({
    double fontSize = 13,
    Color color = AppColors.textPrimary,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}
