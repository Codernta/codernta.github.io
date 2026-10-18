import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'cyber_interactive_card.dart';

/// Interactive card that elevates and highlights borders smoothly when hovered on web/desktop.
class HoverCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color borderColor;
  final Color hoverBorderColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool enableTilt;

  const HoverCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.backgroundColor = const Color(0xFF111114),
    this.borderColor = const Color(0xFF27272A),
    this.hoverBorderColor = AppColors.neonGreen,
    this.borderRadius = 16.0,
    this.onTap,
    this.enableTilt = true,
  });

  @override
  Widget build(BuildContext context) {
    return CyberInteractiveCard(
      padding: padding,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      borderRadius: borderRadius,
      onTap: onTap,
      enableTilt: enableTilt,
      child: child,
    );
  }
}
