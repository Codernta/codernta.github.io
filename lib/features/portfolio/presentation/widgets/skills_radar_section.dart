import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/cyber_interactive_card.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../domain/entities/skill_category.dart';
import '../controllers/portfolio_controller.dart';

class SkillsRadarSection extends StatefulWidget {
  final List<SkillCategory> skills;
  final PortfolioController controller;

  const SkillsRadarSection({
    super.key,
    required this.skills,
    required this.controller,
  });

  @override
  State<SkillsRadarSection> createState() => _SkillsRadarSectionState();
}

class _SkillsRadarSectionState extends State<SkillsRadarSection>
    with TickerProviderStateMixin {
  late final AnimationController _sweepController;
  late final AnimationController _pulseController;
  late final AnimationController _gaugeFillController;

  @override
  void initState() {
    super.initState();
    _sweepController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _gaugeFillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();
  }

  @override
  void dispose() {
    _sweepController.dispose();
    _pulseController.dispose();
    _gaugeFillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: widget.controller.skillsKey,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 36 : 64,
        horizontal: isMobile ? 12 : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Header
          ScrollReveal(
            child: Center(
              child: Column(
                children: [
                  Text(
                    '// PROFICIENCY & CORE STACK',
                    style: AppTypography.monoBold(
                      fontSize: 11,
                      color: AppColors.neonGreen,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Technical Radar',
                    style: AppTypography.displayBold(
                      fontSize: isMobile ? 28 : 40,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 540),
                    child: Text(
                      'Comprehensive breakdown of modular architecture, protocols, and tooling.',
                      textAlign: TextAlign.center,
                      style: AppTypography.mono(
                        fontSize: 13,
                        color: const Color(0xFFA1A1AA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Main 2-Column Layout
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 150),
                    child: _buildRadarDiagram(context, isMobile: false),
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 7,
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 300),
                    child: _buildCapabilityCards(context),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                ScrollReveal(
                  child: _buildRadarDiagram(context, isMobile: true),
                ),
                const SizedBox(height: 40),
                ScrollReveal(
                  delay: const Duration(milliseconds: 200),
                  child: _buildCapabilityCards(context),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRadarDiagram(BuildContext context, {required bool isMobile}) {
    final size = isMobile ? 280.0 : 340.0;

    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Arc / Gauge Painter with Animated Fill & Continuous Radar Beam Sweep
            AnimatedBuilder(
              animation: Listenable.merge([_gaugeFillController, _sweepController]),
              builder: (context, _) {
                return CustomPaint(
                  size: Size(size, size),
                  painter: _AnimatedRadarGaugePainter(
                    fillProgress: _gaugeFillController.value,
                    sweepAngle: _sweepController.value * 2 * math.pi,
                  ),
                );
              },
            ),

            // Center Green Skill Circle with breathing glow
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, _) {
                final glow = _pulseController.value;
                return Container(
                  width: isMobile ? 96.0 : 112.0,
                  height: isMobile ? 96.0 : 112.0,
                  decoration: BoxDecoration(
                    color: AppColors.neonGreen,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonGreen
                            .withValues(alpha: 0.35 + (0.35 * glow)),
                        blurRadius: 28 + (16 * glow),
                        spreadRadius: 1 + (2 * glow),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Skill',
                        style: AppTypography.displayBold(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '95% CORE',
                        style: AppTypography.monoBold(
                          fontSize: 10,
                          color: const Color(0xCC000000),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Node A (Architecture)
            Positioned(
              right: isMobile ? 20 : 32,
              top: size / 2 - 20,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.neonGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonGreen.withValues(alpha: 0.5),
                      blurRadius: 15,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'A',
                  style: AppTypography.displayBold(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Node I (Integration)
            Positioned(
              top: isMobile ? 20 : 30,
              left: size / 2 - 18,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF18181B),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF3F3F46)),
                ),
                alignment: Alignment.center,
                child: Text(
                  'I',
                  style: AppTypography.monoBold(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Node S (State BLoC)
            Positioned(
              bottom: isMobile ? 20 : 30,
              left: size / 2 - 18,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF18181B),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF3F3F46)),
                ),
                alignment: Alignment.center,
                child: Text(
                  'S',
                  style: AppTypography.monoBold(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Node P (Performance)
            Positioned(
              left: isMobile ? 24 : 36,
              top: isMobile ? 40 : 54,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF18181B),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF27272A)),
                ),
                alignment: Alignment.center,
                child: Text(
                  'P',
                  style: AppTypography.mono(
                    fontSize: 12,
                    color: const Color(0xFFA1A1AA),
                  ),
                ),
              ),
            ),

            // Floating 95% Flutter Badge
            Positioned(
              right: 0,
              top: isMobile ? 32 : 44,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.neonGreen),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonGreen.withValues(alpha: 0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Text(
                  '95% Flutter',
                  style: AppTypography.monoBold(
                    fontSize: 11,
                    color: AppColors.neonGreen,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCapabilityCards(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCapabilityCard(
          title: 'Flutter & Dart Ecosystem',
          percentage: '95%',
          fraction: 0.95,
          description:
              'Custom Painters, render object pipelines, implicit animations, hardware-accelerated 60/120fps UI.',
        ),
        const SizedBox(height: 14),
        _buildCapabilityCard(
          title: 'State Management (BLoC / GetX)',
          percentage: '92%',
          fraction: 0.92,
          description:
              'Strict Domain-Driven separation, stream transformations, Provider, dependency injection with get_it.',
        ),
        const SizedBox(height: 14),
        _buildCapabilityCard(
          title: 'Real-Time & Geo-Tracking',
          percentage: '90%',
          fraction: 0.90,
          description:
              'WebSockets, Socket.IO live messaging, Google Maps Platform integration, background geofencing.',
        ),
        const SizedBox(height: 14),
        _buildCapabilityCard(
          title: 'Cloud, Firebase & Release CI/CD',
          percentage: '88%',
          fraction: 0.88,
          description:
              'FCM Push Notifications, Google Play Store / TestFlight deployments, keystore signing, Razorpay & Stripe SDKs.',
        ),
        const SizedBox(height: 20),

        // Core Tech Pills with hover scaling
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _SkillBadge('Dart'),
            _SkillBadge('Flutter'),
            _SkillBadge('Clean Architecture'),
            _SkillBadge('BLoC Pattern'),
            _SkillBadge('GetX'),
            _SkillBadge('Provider'),
            _SkillBadge('Socket.IO'),
            _SkillBadge('Google Maps'),
            _SkillBadge('OpenAI APIs'),
            _SkillBadge('BLE Hardware'),
            _SkillBadge('Firebase Cloud'),
            _SkillBadge('REST APIs'),
            _SkillBadge('CI/CD Pipelines'),
            _SkillBadge('Razorpay / Stripe'),
          ],
        ),
      ],
    );
  }

  Widget _buildCapabilityCard({
    required String title,
    required String percentage,
    required double fraction,
    required String description,
  }) {
    return CyberInteractiveCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 14,
      enableTilt: true,
      maxTilt: 0.04,
      liftOffset: -4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.displayBold(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Text(
                percentage,
                style: AppTypography.monoBold(
                  fontSize: 13,
                  color: AppColors.neonGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Animated Progress Bar with glowing tip
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: fraction),
              duration: const Duration(milliseconds: 1400),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) {
                return Stack(
                  children: [
                    Container(
                      height: 5,
                      color: const Color(0xFF1F1F24),
                    ),
                    FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.neonGreen,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.neonGreen.withValues(alpha: 0.8),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: AppTypography.mono(
              fontSize: 12,
              color: const Color(0xFFA1A1AA),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillBadge extends StatefulWidget {
  final String label;

  const _SkillBadge(this.label);

  @override
  State<_SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<_SkillBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFF1F1F26) : const Color(0xFF0D0D10),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered ? AppColors.neonGreen : const Color(0xFF27272A),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.neonGreen.withValues(alpha: 0.2),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: Text(
          widget.label,
          style: AppTypography.mono(
            fontSize: 11,
            color: _isHovered ? AppColors.neonGreen : const Color(0xFFE4E4E7),
          ),
        ),
      ),
    );
  }
}

class _AnimatedRadarGaugePainter extends CustomPainter {
  final double fillProgress;
  final double sweepAngle;

  _AnimatedRadarGaugePainter({
    required this.fillProgress,
    required this.sweepAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;

    // Background circle dashed
    final bgPaint = Paint()
      ..color = const Color(0xFF27272A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const dashCount = 48;
    const sweep = (2 * math.pi) / dashCount;
    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * sweep,
        sweep * 0.5,
        false,
        bgPaint,
      );
    }

    // Glowing Neon Green Arc (Animates up to 88% / 95% full circle)
    final targetSweep = 2 * math.pi * 0.88 * fillProgress;
    final arcPaint = Paint()
      ..color = AppColors.neonGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      targetSweep,
      false,
      arcPaint,
    );

    // Rotating Radar Beam Line & Subtle Trail
    final beamEndX = center.dx + radius * math.cos(sweepAngle);
    final beamEndY = center.dy + radius * math.sin(sweepAngle);

    final beamPaint = Paint()
      ..color = AppColors.neonGreen.withValues(alpha: 0.45)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    canvas.drawLine(center, Offset(beamEndX, beamEndY), beamPaint);
  }

  @override
  bool shouldRepaint(covariant _AnimatedRadarGaugePainter oldDelegate) =>
      oldDelegate.fillProgress != fillProgress ||
      oldDelegate.sweepAngle != sweepAngle;
}
