import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A futuristic cyber telemetry beacon with expanding concentric radar pulse rings.
class PulsingRadarDot extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;

  const PulsingRadarDot({
    super.key,
    this.size = 8.0,
    this.color = AppColors.neonGreen,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<PulsingRadarDot> createState() => _PulsingRadarDotState();
}

class _PulsingRadarDotState extends State<PulsingRadarDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ringMaxSize = widget.size * 2.8;

    return SizedBox(
      width: ringMaxSize,
      height: ringMaxSize,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value;
            final ringScale = 1.0 + (t * 1.8);
            final ringOpacity = (1.0 - t).clamp(0.0, 0.8);

            return Stack(
              alignment: Alignment.center,
              children: [
                // Expanding outer radar ping
                Transform.scale(
                  scale: ringScale,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.color.withValues(alpha: ringOpacity * 0.7),
                        width: 1.2,
                      ),
                    ),
                  ),
                ),

                // Secondary soft glow ping
                Transform.scale(
                  scale: 1.0 + (t * 1.0),
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.color.withValues(alpha: ringOpacity * 0.25),
                    ),
                  ),
                ),

                // Core solid dot with glow
                Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.8),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
