import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A futuristic cyber card featuring 3D perspective tilt, holographic cursor flashlight,
/// vertical elevation lift, and vibrant neon border bloom.
class CyberInteractiveCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color borderColor;
  final Color hoverBorderColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final double maxTilt;
  final double liftOffset;
  final bool enableTilt;
  final bool enableSpotlight;

  const CyberInteractiveCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.backgroundColor = const Color(0xFF111114),
    this.borderColor = const Color(0xFF27272A),
    this.hoverBorderColor = AppColors.neonGreen,
    this.borderRadius = 20.0,
    this.onTap,
    this.maxTilt = 0.06, // subtle ~3.5 degrees
    this.liftOffset = -6.0,
    this.enableTilt = true,
    this.enableSpotlight = true,
  });

  @override
  State<CyberInteractiveCard> createState() => _CyberInteractiveCardState();
}

class _CyberInteractiveCardState extends State<CyberInteractiveCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  Offset _pointerPosition = Offset.zero;
  Offset _targetTilt = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (e) {
        setState(() {
          _isHovered = true;
          _updatePointer(e.localPosition, context.size ?? const Size(300, 300));
        });
      },
      onHover: (e) {
        _updatePointer(e.localPosition, context.size ?? const Size(300, 300));
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
          _targetTilt = Offset.zero;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: _isHovered ? 1.0 : 0.0),
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          builder: (context, hoverValue, _) {
            final currentTiltX = _targetTilt.dx * hoverValue;
            final currentTiltY = _targetTilt.dy * hoverValue;
            final currentLift = widget.liftOffset * hoverValue;

            Matrix4 transform = Matrix4.identity();
            if (widget.enableTilt) {
              transform = Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateX(-currentTiltY * widget.maxTilt)
                ..rotateY(currentTiltX * widget.maxTilt)
                ..translate(0.0, currentLift);
            } else {
              transform = Matrix4.identity()..translate(0.0, currentLift);
            }

            return Transform(
              alignment: FractionalOffset.center,
              transform: transform,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: Color.lerp(
                      widget.borderColor,
                      widget.hoverBorderColor.withValues(alpha: 0.85),
                      hoverValue,
                    )!,
                    width: 1.2,
                  ),
                  boxShadow: hoverValue > 0
                      ? [
                          BoxShadow(
                            color: widget.hoverBorderColor
                                .withValues(alpha: 0.18 * hoverValue),
                            blurRadius: 24,
                            spreadRadius: 1,
                            offset: const Offset(0, 6),
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Stack(
                  children: [
                    // Holographic cursor spotlight reflection
                    if (widget.enableSpotlight && hoverValue > 0)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(widget.borderRadius),
                              gradient: RadialGradient(
                                center: Alignment(
                                  _pointerPosition.dx.clamp(-1.0, 1.0),
                                  _pointerPosition.dy.clamp(-1.0, 1.0),
                                ),
                                radius: 0.85,
                                colors: [
                                  widget.hoverBorderColor.withValues(
                                    alpha: 0.09 * hoverValue,
                                  ),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 1.0],
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Card Content
                    Padding(
                      padding: widget.padding,
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _updatePointer(Offset localPos, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    final normalizedX = (localPos.dx / size.width) * 2.0 - 1.0;
    final normalizedY = (localPos.dy / size.height) * 2.0 - 1.0;
    setState(() {
      _pointerPosition = Offset(normalizedX, normalizedY);
      _targetTilt = Offset(
        normalizedX.clamp(-1.0, 1.0),
        normalizedY.clamp(-1.0, 1.0),
      );
    });
  }
}
