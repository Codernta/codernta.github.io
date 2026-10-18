import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/primary_button.dart';
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
    with SingleTickerProviderStateMixin {
  late final AnimationController _orbitController;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();
  }

  @override
  void dispose() {
    _orbitController.dispose();
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
                  child: _buildLeftHero(context, isMobile: false),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 5,
                  child: _buildRightOrbitalRadar(context, isMobile: false),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildRightOrbitalRadar(context, isMobile: true),
                const SizedBox(height: 36),
                _buildLeftHero(context, isMobile: true),
              ],
            ),
    );
  }

  Widget _buildLeftHero(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Tagline Pill
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
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: AppColors.neonGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonGreen.withValues(alpha: 0.6),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
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

        // Main Headline with Stitch Inline Neon Badge
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          runSpacing: 8,
          children: [
            Text(
              'Hi, Nithin T A—',
              style: AppTypography.displayExtraBold(
                fontSize: isMobile ? 36 : 60,
                color: Colors.white,
                letterSpacing: -1.0,
                height: 1.1,
              ),
            ),
            Transform.rotate(
              angle: -0.02,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 18,
                  vertical: isMobile ? 4 : 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.neonGreen,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonGreen.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'FLUTTER DEVELOPER',
                  style: AppTypography.displayBold(
                    fontSize: isMobile ? 22 : 36,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Subtitle / Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            'Specialized in Clean Architecture, BLoC, high-throughput Socket.IO real-time systems, and 120 FPS custom canvas rendering. Shipped 5+ enterprise and consumer mobile applications with seamless hardware and cloud integration.',
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
              _buildTelemetryItem('₹8.0 LPA Target'),
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
            // Outer Concentric Ring
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

            // Middle Dashed / Radar Ring (Rotates continuously)
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

            // Inner Neon Subtle Orbit Ring
            Container(
              width: size * 0.65,
              height: size * 0.65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.neonGreen.withValues(alpha: 0.25),
                  width: 1.2,
                ),
              ),
            ),

            // Center Glowing Avatar Container with Nithin's Photo
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonGreen.withValues(alpha: 0.35),
                    blurRadius: 40,
                    spreadRadius: 2,
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
                child: Image.asset(
                  'assets/images/nithin_profile.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/nithin_cutout.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),

            // Satellite Orbit Nodes (Positions from Stitch Reference)
            // Node 1: "FL" (Top Right)
            Positioned(
              top: isMobile ? 12 : 24,
              right: isMobile ? 24 : 40,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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

            // Node 2: "BLoC" (Bottom Right)
            Positioned(
              bottom: isMobile ? 24 : 36,
              right: isMobile ? 16 : 28,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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

            // Node 3: "IO" (Socket.IO - Top Left)
            Positioned(
              top: isMobile ? 32 : 50,
              left: isMobile ? 16 : 28,
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

            // Node 4: "Dart" (Bottom Left)
            Positioned(
              bottom: isMobile ? 28 : 44,
              left: isMobile ? 28 : 44,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
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

            // Floating Bottom Availability Pill
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.neonGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonGreen.withValues(alpha: 0.8),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
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

  const _DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);
    const dashCount = 36;
    const sweep = (2 * math.pi) / dashCount;
    const dashLength = sweep * 0.55;

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
      oldDelegate.color != color;
}
