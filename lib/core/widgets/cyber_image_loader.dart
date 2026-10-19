import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

/// A cyber-neon profile image widget featuring an animated biometric scanner,
/// laser scanline sweep, tactical HUD reticle, and smooth cross-fade upon asset decode.
class CyberProfileImage extends StatelessWidget {
  final String imagePath;
  final String? fallbackPath;
  final BoxFit fit;
  final Alignment alignment;
  final double? width;
  final double? height;
  final bool isCircle;
  final BorderRadius? borderRadius;
  final String loadingLabel;
  final bool showScanline;

  const CyberProfileImage({
    super.key,
    required this.imagePath,
    this.fallbackPath,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.isCircle = false,
    this.borderRadius,
    this.loadingLabel = 'INITIALIZING_FEED',
    this.showScanline = true,
  });

  Widget _buildImageWithLoader({
    required BuildContext context,
    required String path,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
  }) {
    return Image.asset(
      path,
      fit: fit,
      alignment: alignment,
      width: width,
      height: height,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: frame != null
              ? KeyedSubtree(
                  key: ValueKey('loaded_${path.hashCode}'),
                  child: child,
                )
              : KeyedSubtree(
                  key: ValueKey('loading_${path.hashCode}'),
                  child: CyberImageLoader(
                    isCircle: isCircle,
                    borderRadius: borderRadius,
                    label: loadingLabel,
                    showScanline: showScanline,
                  ),
                ),
        );
      },
      errorBuilder: errorBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildImageWithLoader(
      context: context,
      path: imagePath,
      errorBuilder: fallbackPath != null
          ? (context, error, stackTrace) {
              return _buildImageWithLoader(
                context: context,
                path: fallbackPath!,
                errorBuilder: (context, error, stackTrace) {
                  return CyberImageLoader(
                    isCircle: isCircle,
                    borderRadius: borderRadius,
                    label: 'OFFLINE_CACHE',
                    showScanline: false,
                  );
                },
              );
            }
          : (context, error, stackTrace) {
              return CyberImageLoader(
                isCircle: isCircle,
                borderRadius: borderRadius,
                label: 'STREAM_ERROR',
                showScanline: false,
              );
            },
    );
  }
}

/// Cybernetic loading placeholder designed for futuristic sci-fi aesthetic.
/// Features animated laser scanline, rotating biometric reticle, holographic grid, and telemetry.
class CyberImageLoader extends StatefulWidget {
  final bool isCircle;
  final BorderRadius? borderRadius;
  final String label;
  final bool showScanline;

  const CyberImageLoader({
    super.key,
    this.isCircle = false,
    this.borderRadius,
    this.label = 'SCANNING...',
    this.showScanline = true,
  });

  @override
  State<CyberImageLoader> createState() => _CyberImageLoaderState();
}

class _CyberImageLoaderState extends State<CyberImageLoader>
    with TickerProviderStateMixin {
  late final AnimationController _scanController;
  late final AnimationController _reticleController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    // Laser scanline sweeping vertically back and forth
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    // Continuous 360-degree rotation for targeting reticle
    _reticleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000),
    )..repeat();

    // Breathing glow & telemetry pulse
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanController.dispose();
    _reticleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0C0C0F),
        shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: widget.isCircle ? null : widget.borderRadius,
        gradient: const RadialGradient(
          center: Alignment.center,
          radius: 0.9,
          colors: [
            Color(0xFF141419),
            Color(0xFF070709),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          // 1. Subtle Cyber Matrix Grid
          CustomPaint(
            painter: _CyberGridPainter(
              isCircle: widget.isCircle,
            ),
          ),

          // 2. High-Tech Tactical Corner HUD Brackets (for rectangular frames)
          if (!widget.isCircle)
            const CustomPaint(
              painter: _CornerBracketsPainter(),
            ),

          // 3. Center Holographic Biometric Reticle & Status Telemetry
          Center(
            child: _buildCenterHoloReticle(),
          ),

          // 4. Moving Laser Scanline with Glowing Gradient Trail
          if (widget.showScanline)
            AnimatedBuilder(
              animation: _scanController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _LaserScanlinePainter(
                    progress: _scanController.value,
                    color: AppColors.neonGreen,
                  ),
                );
              },
            ),

          // 5. Ambient Cyber Shimmer Flare passing diagonally
          AnimatedBuilder(
            animation: _scanController,
            builder: (context, _) {
              return CustomPaint(
                painter: _DiagonalShimmerPainter(
                  progress: _scanController.value,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCenterHoloReticle() {
    return AnimatedBuilder(
      animation: Listenable.merge([_reticleController, _pulseController]),
      builder: (context, child) {
        final pulse = _pulseController.value;
        final rot = _reticleController.value * 2 * math.pi;

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rotating outer segmented targeting ring + center glyph
            SizedBox(
              width: widget.isCircle ? 84 : 94,
              height: widget.isCircle ? 84 : 94,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer rotating dashed reticle ring
                  Transform.rotate(
                    angle: rot,
                    child: CustomPaint(
                      size: const Size(84, 84),
                      painter: _DashedReticlePainter(
                        color: AppColors.neonGreen.withValues(
                          alpha: 0.25 + (0.35 * pulse),
                        ),
                        dashCount: 16,
                        strokeWidth: 1.5,
                      ),
                    ),
                  ),
                  // Inner counter-rotating thin ring
                  Transform.rotate(
                    angle: -rot * 0.75,
                    child: CustomPaint(
                      size: const Size(64, 64),
                      painter: _DashedReticlePainter(
                        color: const Color(0xFF3F3F46).withValues(alpha: 0.6),
                        dashCount: 8,
                        strokeWidth: 1.0,
                      ),
                    ),
                  ),
                  // Breathing glow backdrop
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonGreen.withValues(
                            alpha: 0.15 + (0.25 * pulse),
                          ),
                          blurRadius: 18 + (10 * pulse),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  // Center Biometric / Tech Glyph Icon
                  Icon(
                    Icons.fingerprint_rounded,
                    size: widget.isCircle ? 34 : 38,
                    color: AppColors.neonGreen.withValues(
                      alpha: 0.8 + (0.2 * pulse),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Futuristic Monospace Status Telemetry Chip
            _buildStatusChip(pulse),
          ],
        );
      },
    );
  }

  Widget _buildStatusChip(double pulse) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.neonGreen.withValues(alpha: 0.25 + (0.35 * pulse)),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulsing green beacon dot
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.neonGreen,
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonGreen.withValues(alpha: 0.8),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            widget.label.toUpperCase(),
            style: AppTypography.mono(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: AppColors.neonGreen,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _LaserScanlinePainter extends CustomPainter {
  final double progress;
  final Color color;

  const _LaserScanlinePainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final y = progress * size.height;
    const beamHeight = 44.0;

    // Laser glow gradient above and below the beam
    final glowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.0),
          color.withValues(alpha: 0.20),
          color.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(
        Rect.fromLTWH(0, y - beamHeight / 2, size.width, beamHeight),
      );

    canvas.drawRect(
      Rect.fromLTWH(0, y - beamHeight / 2, size.width, beamHeight),
      glowPaint,
    );

    // Sharp core laser line
    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.85)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);

    // Center bright hotspot on the laser line
    final hotspotPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withValues(alpha: 0.9),
          color.withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromCenter(
          center: Offset(size.width / 2, y),
          width: size.width * 0.45,
          height: 8,
        ),
      );

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, y),
        width: size.width * 0.45,
        height: 6,
      ),
      hotspotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _LaserScanlinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

class _CornerBracketsPainter extends CustomPainter {
  const _CornerBracketsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonGreen.withValues(alpha: 0.45)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const len = 14.0;
    const pad = 10.0;

    // Top Left ┌
    canvas.drawLine(const Offset(pad, pad), const Offset(pad + len, pad), paint);
    canvas.drawLine(const Offset(pad, pad), const Offset(pad, pad + len), paint);

    // Top Right ┐
    canvas.drawLine(
      Offset(size.width - pad, pad),
      Offset(size.width - pad - len, pad),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - pad, pad),
      Offset(size.width - pad, pad + len),
      paint,
    );

    // Bottom Left └
    canvas.drawLine(
      Offset(pad, size.height - pad),
      Offset(pad + len, size.height - pad),
      paint,
    );
    canvas.drawLine(
      Offset(pad, size.height - pad),
      Offset(pad, size.height - pad - len),
      paint,
    );

    // Bottom Right ┘
    canvas.drawLine(
      Offset(size.width - pad, size.height - pad),
      Offset(size.width - pad - len, size.height - pad),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - pad, size.height - pad),
      Offset(size.width - pad, size.height - pad - len),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CyberGridPainter extends CustomPainter {
  final bool isCircle;

  const _CyberGridPainter({this.isCircle = false});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF27272A).withValues(alpha: 0.35)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    const step = 24.0;

    for (double x = step; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = step; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DashedReticlePainter extends CustomPainter {
  final Color color;
  final int dashCount;
  final double strokeWidth;

  const _DashedReticlePainter({
    required this.color,
    this.dashCount = 12,
    this.strokeWidth = 1.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    final arcAngle = (2 * math.pi) / dashCount;
    final sweepAngle = arcAngle * 0.55;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * arcAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedReticlePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashCount != dashCount ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class _DiagonalShimmerPainter extends CustomPainter {
  final double progress;

  const _DiagonalShimmerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final bandWidth = size.width * 0.6;
    final totalDistance = size.width + size.height + bandWidth;
    final currentOffset = (progress * totalDistance) - bandWidth;

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.transparent,
          AppColors.neonGreen.withValues(alpha: 0.05),
          Colors.white.withValues(alpha: 0.08),
          AppColors.neonGreen.withValues(alpha: 0.05),
          Colors.transparent,
        ],
        stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
      ).createShader(Rect.fromLTWH(currentOffset, 0, bandWidth, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _DiagonalShimmerPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
