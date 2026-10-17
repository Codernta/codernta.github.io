import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Interactive card that elevates and highlights borders smoothly when hovered on web/desktop.
class HoverCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color borderColor;
  final Color hoverBorderColor;
  final double borderRadius;
  final VoidCallback? onTap;

  const HoverCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.backgroundColor = AppColors.card,
    this.borderColor = AppColors.border,
    this.hoverBorderColor = AppColors.flutterCyan,
    this.borderRadius = 16.0,
    this.onTap,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.backgroundColor.withValues(alpha: 0.95)
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _isHovered ? widget.hoverBorderColor : widget.borderColor,
              width: 1.2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.hoverBorderColor.withValues(alpha: 0.08),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
