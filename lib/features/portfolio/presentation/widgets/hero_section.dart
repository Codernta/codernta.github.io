import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/cyber_image_loader.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/pulsing_radar_dot.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../domain/entities/developer_profile.dart';
import '../controllers/portfolio_controller.dart';

class HeroSection extends StatefulWidget {
  final DeveloperProfile profile;
  final PortfolioController controller;

  const HeroSection({
    super.key,
    required this.profile,
    required this.controller,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _orbitController;
  late final AnimationController _counterOrbitController;
  late final AnimationController _radarSweepController;
  late final AnimationController _levitationController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    // 1. Clockwise outer orbit
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat();

    // 2. Counter-clockwise inner orbit
    _counterOrbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat(reverse: false);

    // 3. Radar beam sweep (fast tactical radar line)
    _radarSweepController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    // 4. Harmonic sine levitation for satellites
    _levitationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // 5. Neon breathing pulse
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _counterOrbitController.dispose();
    _radarSweepController.dispose();
    _levitationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: widget.controller.heroKey,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 56,
        horizontal: isMobile ? 8 : 24,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: ScrollReveal(
                    duration: const Duration(milliseconds: 700),
                    child: _buildLeftHero(context, isMobile: false),
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 5,
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 200),
                    child: _buildRightOrbitalRadar(context, isMobile: false),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ScrollReveal(
                  child: _buildRightOrbitalRadar(context, isMobile: true),
                ),
                const SizedBox(height: 36),
                ScrollReveal(
                  delay: const Duration(milliseconds: 150),
                  child: _buildLeftHero(context, isMobile: true),
                ),
              ],
            ),
    );
  }

  Widget _buildLeftHero(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Tagline Pill with pulsing beacon
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF111114),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: const Color(0xFF27272A)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PulsingRadarDot(size: 7),
              const SizedBox(width: 8),
              Text(
                '4+ YEARS SENIOR FLUTTER SPECIALIST',
                style: AppTypography.monoBold(
                  fontSize: 11,
                  color: AppColors.neonGreen,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Main Headline with Stitch Inline Neon Badge (Breathing Glow Animation)
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 14,
          runSpacing: 10,
          children: [
            Text(
              'Nithin T A',
              style: AppTypography.displayExtraBold(
                fontSize: isMobile ? 36 : 58,
                color: Colors.white,
                letterSpacing: -1.0,
                height: 1.1,
              ),
            ),
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final glow = _pulseController.value;
                return Transform.rotate(
                  angle: -0.02,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 18,
                      vertical: isMobile ? 5 : 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.neonGreen,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonGreen
                              .withValues(alpha: 0.35 + (0.35 * glow)),
                          blurRadius: 16 + (16 * glow),
                          spreadRadius: 1 + (2 * glow),
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      'SENIOR FLUTTER DEVELOPER',
                      style: AppTypography.displayBold(
                        fontSize: isMobile ? 18 : 30,
                        color: Colors.black,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Subtitle / Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            'Specialized in Clean Architecture, BLoC, high-throughput Socket.IO real-time systems, and 120 FPS custom canvas rendering. Shipped 7+ enterprise and consumer mobile applications with seamless hardware and cloud integration.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: AppTypography.mono(
              fontSize: isMobile ? 13 : 15,
              color: const Color(0xFFA1A1AA),
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Action Buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PrimaryButton(
              label: 'VIEW WORK',
              variant: ButtonVariant.primary,
              showArrow: true,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              onPressed: () => widget.controller.scrollToSection(
                widget.controller.projectsKey,
                'projects',
              ),
            ),
            PrimaryButton(
              label: 'HIRE ME (0 NOTICE)',
              variant: ButtonVariant.outline,
              showArrow: true,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              onPressed: () => widget.controller.scrollToSection(
                widget.controller.contactKey,
                'contact',
              ),
            ),
          ],
        ),
        const SizedBox(height: 36),

        // Telemetry Metadata Strip
        Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFF18181B), width: 1),
            ),
          ),
          child: Wrap(
            spacing: 20,
            runSpacing: 8,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildTelemetryItem('Ex-IIC Web Solutions'),
              Text('|', style: AppTypography.mono(color: const Color(0xFF3F3F46))),
              _buildTelemetryItem('0 Notice Period (Immediate)'),
              Text('|', style: AppTypography.mono(color: const Color(0xFF3F3F46))),
              _buildTelemetryItem(widget.profile.workPreference),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTelemetryItem(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.neonGreen,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTypography.mono(
            fontSize: 12,
            color: const Color(0xFFE4E4E7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRightOrbitalRadar(BuildContext context, {required bool isMobile}) {
    final size = isMobile ? 300.0 : 400.0;
    final avatarSize = isMobile ? 180.0 : 220.0;

    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Outer Concentric Ring
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF27272A).withValues(alpha: 0.7),
                  width: 1,
                ),
              ),
            ),

            // 2. Middle Dashed / Radar Ring (Rotates Clockwise continuously)
            AnimatedBuilder(
              animation: _orbitController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _orbitController.value * 2 * math.pi,
                  child: child,
                );
              },
              child: CustomPaint(
                size: Size(size * 0.82, size * 0.82),
                painter: _DashedCirclePainter(
                  color: const Color(0xFF3F3F46).withValues(alpha: 0.7),
                ),
              ),
            ),

            // 3. Inner Counter-Rotating Dashed Orbit Ring
            AnimatedBuilder(
              animation: _counterOrbitController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: -_counterOrbitController.value * 2 * math.pi,
                  child: child,
                );
              },
              child: CustomPaint(
                size: Size(size * 0.65, size * 0.65),
                painter: _DashedCirclePainter(
                  color: AppColors.neonGreen.withValues(alpha: 0.35),
                  dashCount: 24,
                  strokeWidth: 1.0,
                ),
              ),
            ),

            // 4. Live Tactical Radar Beam Sweep
            AnimatedBuilder(
              animation: _radarSweepController,
              builder: (context, _) {
                return CustomPaint(
                  size: Size(size * 0.82, size * 0.82),
                  painter: _RadarBeamSweepPainter(
                    angle: _radarSweepController.value * 2 * math.pi,
                  ),
                );
              },
            ),

            // 5. Center Glowing Avatar Container with Nithin's Photo & Breathing Glow
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final glow = _pulseController.value;
                return Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonGreen
                            .withValues(alpha: 0.25 + (0.25 * glow)),
                        blurRadius: 32 + (20 * glow),
                        spreadRadius: 1 + (3 * glow),
                      ),
                    ],
                    gradient: const RadialGradient(
                      colors: [
                        Color(0xFF1A1A1F),
                        Color(0xFF0D0D10),
                      ],
                    ),
                    border: Border.all(
                      color: AppColors.neonGreen,
                      width: 2.5,
                    ),
                  ),
                  child: ClipOval(
                    child: CyberProfileImage(
                      imagePath: 'assets/images/nithin_profile.png',
                      fallbackPath: 'assets/images/nithin_cutout.png',
                      isCircle: true,
                      fit: BoxFit.cover,
                      width: avatarSize,
                      height: avatarSize,
                      loadingLabel: 'AVATAR_STREAM',
                    ),
                  ),
                );
              },
            ),

            // 6. Levitating Satellite Orbit Nodes (Harmonic Sine Oscillation)
            // Node 1: "FL" (Top Right)
            Positioned(
              top: isMobile ? 12.0 : 24.0,
              right: isMobile ? 24 : 40,
              child: AnimatedBuilder(
                animation: _levitationController,
                builder: (context, child) {
                  final t = _levitationController.value * 2 * math.pi;
                  return Transform.translate(
                    offset: Offset(0, math.sin(t) * 6.0),
                    child: child,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.neonGreen,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonGreen.withValues(alpha: 0.6),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Text(
                    'FL',
                    style: AppTypography.monoBold(
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // Node 2: "BLoC" (Bottom Right)
            Positioned(
              bottom: isMobile ? 24.0 : 36.0,
              right: isMobile ? 16 : 28,
              child: AnimatedBuilder(
                animation: _levitationController,
                builder: (context, child) {
                  final t = _levitationController.value * 2 * math.pi;
                  return Transform.translate(
                    offset: Offset(0, math.cos(t + 1.2) * 5.0),
                    child: child,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111114),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: const Color(0xFF3F3F46)),
                  ),
                  child: Text(
                    'BLoC',
                    style: AppTypography.monoBold(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Node 3: "IO" (Socket.IO - Top Left)
            Positioned(
              top: isMobile ? 32.0 : 50.0,
              left: isMobile ? 16 : 28,
              child: AnimatedBuilder(
                animation: _levitationController,
                builder: (context, child) {
                  final t = _levitationController.value * 2 * math.pi;
                  return Transform.translate(
                    offset: Offset(0, math.sin(t + 2.5) * 6.0),
                    child: child,
                  );
                },
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFF111114),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.neonGreen.withValues(alpha: 0.7),
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'IO',
                    style: AppTypography.monoBold(
                      fontSize: 11,
                      color: AppColors.neonGreen,
                    ),
                  ),
                ),
              ),
            ),

            // Node 4: "Dart" (Bottom Left)
            Positioned(
              bottom: isMobile ? 28.0 : 44.0,
              left: isMobile ? 28 : 44,
              child: AnimatedBuilder(
                animation: _levitationController,
                builder: (context, child) {
                  final t = _levitationController.value * 2 * math.pi;
                  return Transform.translate(
                    offset: Offset(0, math.cos(t + 3.8) * 5.0),
                    child: child,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 9, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111114),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: const Color(0xFF27272A)),
                  ),
                  child: Text(
                    'Dart',
                    style: AppTypography.mono(
                      fontSize: 10,
                      color: const Color(0xFFA1A1AA),
                    ),
                  ),
                ),
              ),
            ),

            // 7. Floating Bottom Availability Pill with Pulsing Radar Beacon
            Positioned(
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF050505),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.neonGreen, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.8),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const PulsingRadarDot(size: 8),
                    const SizedBox(width: 8),
                    Text(
                      'Available Now • 0 Days Notice',
                      style: AppTypography.monoBold(
                        fontSize: 11,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final int dashCount;
  final double strokeWidth;

  const _DashedCirclePainter({
    required this.color,
    this.dashCount = 36,
    this.strokeWidth = 1.2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final sweep = (2 * math.pi) / dashCount;
    final dashLength = sweep * 0.55;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * sweep;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashLength,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.dashCount != dashCount ||
      oldDelegate.strokeWidth != strokeWidth;
}

class _RadarBeamSweepPainter extends CustomPainter {
  final double angle;

  const _RadarBeamSweepPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Sweeping gradient trail (wedge) behind the beam
    const trailAngle = math.pi * 0.28; // ~50 degrees
    final rect = Rect.fromCircle(center: center, radius: radius);

    final sweepGradient = SweepGradient(
      center: Alignment.center,
      startAngle: 0.0,
      endAngle: 2 * math.pi,
      transform: GradientRotation(angle - trailAngle),
      colors: [
        Colors.transparent,
        AppColors.neonGreen.withValues(alpha: 0.0),
        AppColors.neonGreen.withValues(alpha: 0.16),
        AppColors.neonGreen.withValues(alpha: 0.35),
      ],
      stops: [
        0.0,
        1.0 - (trailAngle / (2 * math.pi)),
        1.0 - (trailAngle / (4 * math.pi)),
        1.0,
      ],
    );

    final fillPaint = Paint()
      ..shader = sweepGradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, fillPaint);

    // Glowing leading edge line of the radar
    final endX = center.dx + radius * math.cos(angle);
    final endY = center.dy + radius * math.sin(angle);

    final linePaint = Paint()
      ..color = AppColors.neonGreen.withValues(alpha: 0.85)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    canvas.drawLine(center, Offset(endX, endY), linePaint);
  }

  @override
  bool shouldRepaint(covariant _RadarBeamSweepPainter oldDelegate) =>
      oldDelegate.angle != angle;
}
