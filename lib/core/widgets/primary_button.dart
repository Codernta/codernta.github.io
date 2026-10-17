import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

enum ButtonVariant { primary, outline, subtle, textLink }

/// Modern action button with arrow icon and hover transitions.
class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool showArrow;
  final EdgeInsetsGeometry padding;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.showArrow = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color getBgColor() {
      switch (widget.variant) {
        case ButtonVariant.primary:
          return _isHovered ? AppColors.cyanAccent : AppColors.flutterCyan;
        case ButtonVariant.outline:
          return _isHovered ? AppColors.border : Colors.transparent;
        case ButtonVariant.subtle:
          return _isHovered ? AppColors.cardHover : AppColors.card;
        case ButtonVariant.textLink:
          return Colors.transparent;
      }
    }

    Color getTextColor() {
      switch (widget.variant) {
        case ButtonVariant.primary:
          return const Color(0xFF070708);
        case ButtonVariant.outline:
          return _isHovered ? AppColors.flutterCyan : AppColors.textPrimary;
        case ButtonVariant.subtle:
          return _isHovered ? AppColors.flutterCyan : AppColors.textPrimary;
        case ButtonVariant.textLink:
          return _isHovered ? Colors.white : AppColors.flutterCyan;
      }
    }

    Border? getBorder() {
      switch (widget.variant) {
        case ButtonVariant.primary:
          return null;
        case ButtonVariant.outline:
          return Border.all(
            color: _isHovered ? AppColors.flutterCyan : AppColors.border,
            width: 1.2,
          );
        case ButtonVariant.subtle:
          return Border.all(
            color: _isHovered ? AppColors.borderBright : AppColors.border,
            width: 1,
          );
        case ButtonVariant.textLink:
          return null;
      }
    }

    return MouseRegion(
      cursor: widget.onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.forbidden,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: getBgColor(),
            borderRadius: BorderRadius.circular(8),
            border: getBorder(),
            boxShadow: widget.variant == ButtonVariant.primary && _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.flutterCyan.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 16, color: getTextColor()),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: AppTypography.monoBold(
                  fontSize: 12,
                  color: getTextColor(),
                  letterSpacing: 0.5,
                ),
              ),
              if (widget.showArrow) ...[
                const SizedBox(width: 6),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 200),
                  offset: _isHovered ? const Offset(0.15, -0.15) : Offset.zero,
                  child: Text(
                    '↗',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: getTextColor(),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
