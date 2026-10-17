import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

/// Reusable section title component matching the Stitch design.
class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTypography.mono(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.flutterCyan,
                letterSpacing: 1.2,
              ),
            ),
            ?trailing,
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTypography.displayBold(
            fontSize: 28,
            color: AppColors.textPrimary,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              subtitle!,
              style: AppTypography.sans(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
