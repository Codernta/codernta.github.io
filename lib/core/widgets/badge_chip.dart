import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

/// Monospace badge chip used for technical tags, skill pills, and status indicators.
class BadgeChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Widget? leading;
  final EdgeInsetsGeometry padding;

  const BadgeChip({
    super.key,
    required this.label,
    this.backgroundColor = const Color(0xFF18181B),
    this.borderColor = AppColors.border,
    this.textColor = AppColors.textSecondary,
    this.leading,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  });

  factory BadgeChip.liveIndicator() {
    return BadgeChip(
      label: 'LIVE',
      backgroundColor: AppColors.emeraldLive.withValues(alpha: 0.12),
      borderColor: AppColors.emeraldLive.withValues(alpha: 0.4),
      textColor: AppColors.emeraldLive,
      leading: Container(
        width: 6,
        height: 6,
        margin: const EdgeInsets.only(right: 6),
        decoration: const BoxDecoration(
          color: AppColors.emeraldLive,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  factory BadgeChip.verified({String label = 'Play Store Verified'}) {
    return BadgeChip(
      label: label,
      backgroundColor: const Color(0xFF0F0F12),
      borderColor: AppColors.borderMuted,
      textColor: AppColors.textMuted,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ?leading,
          Text(
            label,
            style: AppTypography.mono(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
