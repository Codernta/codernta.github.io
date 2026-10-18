import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'cyber_dots_painter.dart';

/// Ambient cyber backdrop featuring subtle grid dots, drifting floating cyber particles,
/// and an interactive mouse flashlight glow.
class CyberAmbientBackground extends StatefulWidget {
  final Widget child;

  const CyberAmbientBackground({super.key, required this.child});

  @override
  State<CyberAmbientBackground> createState() => _CyberAmbientBackgroundState();
}

class _CyberAmbientBackgroundState extends State<CyberAmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _particleController;
  final List<_CyberParticle> _particles = [];
  final math.Random _rng = math.Random(42);
  Offset _mousePos = const Offset(500, 300);
  bool _mouseActive = false;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    // Initialize 28 subtle floating cyber particles
    for (int i = 0; i < 28; i++) {
      _particles.add(
        _CyberParticle(
          x: _rng.nextDouble(),
          y: _rng.nextDouble(),
          radius: 1.0 + _rng.nextDouble() * 1.8,
          speed: 0.04 + _rng.nextDouble() * 0.08,
          phase: _rng.nextDouble() * 2 * math.pi,
          opacity: 0.15 + _rng.nextDouble() * 0.35,
          color: _rng.nextBool()
              ? AppColors.neonGreen
              : const Color(0xFF00E5FF),
        ),
      );
    }
  }

  @override
  void dispose() {
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (e) {
        if (!_mouseActive || (_mousePos - e.position).distance > 10) {
          setState(() {
            _mousePos = e.position;
            _mouseActive = true;
          });
        }
      },
      child: Stack(
        children: [
          // 1. Static Base Grid Dots
          Positioned.fill(
            child: CustomPaint(
              painter: CyberDotsPainter(
                dotColor: const Color(0x1200FF66),
                spacing: 36.0,
                radius: 0.9,
              ),
            ),
          ),

          // 2. Animated Floating Cyber Dust Particles
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _particleController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _CyberParticlesPainter(
                      particles: _particles,
                      progress: _particleController.value,
                    ),
                  );
                },
              ),
            ),
          ),

          // 3. Interactive Mouse Spotlight Glow
          if (_mouseActive)
            Positioned.fill(
              child: IgnorePointer(
                child: TweenAnimationBuilder<Offset>(
                  tween: Tween<Offset>(begin: _mousePos, end: _mousePos),
                  duration: const Duration(milliseconds: 150),
                  builder: (context, pos, _) {
                    return CustomPaint(
                      painter: _MouseSpotlightPainter(position: pos),
                    );
                  },
                ),
              ),
            ),

          // 4. Foreground Content
          widget.child,
        ],
      ),
    );
  }
}

class _CyberParticle {
  final double x;
  double y;
  final double radius;
  final double speed;
  final double phase;
  final double opacity;
  final Color color;

  _CyberParticle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.phase,
    required this.opacity,
    required this.color,
  });
}

class _CyberParticlesPainter extends CustomPainter {
  final List<_CyberParticle> particles;
  final double progress;

  _CyberParticlesPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    for (final p in particles) {
      // Drifts upwards
      final currentY = (p.y - (progress * p.speed)) % 1.0;
      final actualY = (currentY < 0 ? 1.0 + currentY : currentY) * size.height;

      // Gentle horizontal wave
      final waveX = math.sin(progress * 2 * math.pi + p.phase) * 16.0;
      final actualX = (p.x * size.width) + waveX;

      final paint = Paint()
        ..color = p.color.withValues(alpha: p.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(actualX, actualY), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CyberParticlesPainter oldDelegate) => true;
}

class _MouseSpotlightPainter extends CustomPainter {
  final Offset position;

  _MouseSpotlightPainter({required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment(
          (position.dx / size.width) * 2.0 - 1.0,
          (position.dy / size.height) * 2.0 - 1.0,
        ),
        radius: 0.35,
        colors: [
          AppColors.neonGreen.withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _MouseSpotlightPainter oldDelegate) =>
      oldDelegate.position != position;
}
