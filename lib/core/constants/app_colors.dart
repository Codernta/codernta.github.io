import 'package:flutter/material.dart';

/// Centralized color palette supporting the editorial / neo-brutalist portfolio design.
class AppColors {
  const AppColors._();

  // Stitch Cyber-Neon Reference Palette
  static const Color neonGreen = Color(0xFF00FF66);
  static const Color neonGreenHover = Color(0xFF00DF59);
  static const Color neonGreenGlow = Color(0x6600FF66);
  static const Color neonGreenSubtle = Color(0x1A00FF66);

  static const Color brandDark = Color(0xFF050505);
  static const Color brandSurface = Color(0xFF0D0D0F);
  static const Color brandCard = Color(0xFF111114);
  static const Color brandCardHover = Color(0xFF17171C);
  static const Color brandBorder = Color(0xFF27272A);
  static const Color brandBorderMuted = Color(0xFF18181B);
  static const Color brandSubtext = Color(0xFFA1A1AA);
  static const Color brandMuted = Color(0xFF71717A);

  // Backgrounds & Surfaces (backward compatible aliases)
  static const Color background = Color(0xFF050505);
  static const Color backgroundSecondary = Color(0xFF0D0D0F);
  static const Color card = Color(0xFF111114);
  static const Color cardHover = Color(0xFF17171C);
  static const Color border = Color(0xFF27272A);
  static const Color borderMuted = Color(0xFF18181B);
  static const Color borderBright = Color(0xFF3F3F46);

  // Outer Editorial Framing
  static const Color outerBackdrop = Color(0xFF050505);
  static const Color outerFrameText = Color(0xFFE4E4E7);
  static const Color canvasDark = Color(0xFF050505);
  // Architectural Grid Stage
  static const Color gridPaper = Color(0xFFF3F2EC);
  static const Color gridLine = Color(0xFFDAD8CE);

  // Brand Accents
  static const Color flutterPrimary = Color(0xFF00FF66);
  static const Color flutterCyan = Color(0xFF00FF66);
  static const Color cyanAccent = Color(0xFF00FF66);
  static const Color emeraldLive = Color(0xFF00FF66);
  static const Color amberBadge = Color(0xFFF59E0B);

  // Text Colors
  static const Color textPrimary = Color(0xFFF4F4F5);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textMuted = Color(0xFF71717A);
  static const Color textDisabled = Color(0xFF52525B);

  // Terminal & Status
  static const Color terminalHeader = Color(0xFF18181B);
  static const Color terminalBody = Color(0xFF0E0E11);
  static const Color terminalRed = Color(0xFFEF4444);
  static const Color terminalYellow = Color(0xFFEAB308);
  static const Color terminalGreen = Color(0xFF00FF66);
}
