import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/cyber_interactive_card.dart';
import '../../../../core/widgets/scroll_reveal.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _levitateController;

  @override
  void initState() {
    super.initState();
    _levitateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _levitateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 36 : 64,
        horizontal: isMobile ? 12 : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Title
          ScrollReveal(
            child: Center(
              child: Column(
                children: [
                  Text(
                    '// VERIFIED ENDORSEMENT',
                    style: AppTypography.monoBold(
                      fontSize: 11,
                      color: AppColors.neonGreen,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Testimonial',
                    style: AppTypography.displayBold(
                      fontSize: isMobile ? 28 : 40,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 36),

          // Curved Arc Visual with Centered Lead Card
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Curved Concentric Arc
                  CustomPaint(
                    size: Size(isMobile ? 320 : 460, isMobile ? 140 : 180),
                    painter: _TestimonialArcPainter(),
                  ),

                  // Floating Satellite Avatars along the arc with sine float
                  Positioned(
                    top: 10,
                    left: isMobile ? 30 : 60,
                    child: AnimatedBuilder(
                      animation: _levitateController,
                      builder: (context, _) {
                        final t = _levitateController.value * 2 * math.pi;
                        return Transform.translate(
                          offset: Offset(0, math.sin(t) * 4.0),
                          child: _buildMiniAvatar(Icons.person, isNeon: false),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: isMobile ? 30 : 60,
                    child: AnimatedBuilder(
                      animation: _levitateController,
                      builder: (context, _) {
                        final t = _levitateController.value * 2 * math.pi;
                        return Transform.translate(
                          offset: Offset(0, math.cos(t) * 4.0),
                          child: _buildMiniAvatar(Icons.person, isNeon: false),
                        );
                      },
                    ),
                  ),

                  // Center Testimonial Card with 3D Tilt and Hover Glow
                  Padding(
                    padding: EdgeInsets.only(top: isMobile ? 60 : 70),
                    child: ScrollReveal(
                      delay: const Duration(milliseconds: 150),
                      child: CyberInteractiveCard(
                        padding: const EdgeInsets.all(28),
                        borderRadius: 20,
                        enableTilt: true,
                        maxTilt: 0.04,
                        liftOffset: -6,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Lead Avatar Icon with Neon Ring
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(0xFF18181B),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.neonGreen,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.neonGreen
                                        .withValues(alpha: 0.4),
                                    blurRadius: 15,
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.engineering,
                                color: AppColors.neonGreen,
                                size: 26,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Name & Title
                            Text(
                              'Engineering Lead',
                              style: AppTypography.displayBold(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'IIC Web Solutions',
                              style: AppTypography.mono(
                                fontSize: 12,
                                color: AppColors.neonGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // 5 Stars
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                5,
                                (index) => const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: Icon(
                                    Icons.star,
                                    color: AppColors.neonGreen,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Quote
                            Text(
                              '"Nithin delivers rock-solid Flutter applications with immediate zero-onboarding velocity and clean architecture. His grasp of WebSockets, memory profiling, and reactive states enabled our team to release complex features on schedule."',
                              textAlign: TextAlign.center,
                              style: AppTypography.mono(
                                fontSize: 13,
                                color: const Color(0xFFD4D4D8),
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Carousel Dots
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildDot(isActive: false),
                                const SizedBox(width: 6),
                                _buildDot(isActive: true),
                                const SizedBox(width: 6),
                                _buildDot(isActive: false),
                                const SizedBox(width: 6),
                                _buildDot(isActive: false),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniAvatar(IconData icon, {required bool isNeon}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFF18181B),
        shape: BoxShape.circle,
        border: Border.all(
          color: isNeon ? AppColors.neonGreen : const Color(0xFF3F3F46),
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: 16,
        color: isNeon ? AppColors.neonGreen : const Color(0xFF71717A),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: isActive ? 8 : 6,
      height: isActive ? 8 : 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.neonGreen : const Color(0xFF3F3F46),
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.neonGreen.withValues(alpha: 0.6),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
    );
  }
}

class _TestimonialArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 1.05);
    final radius = size.width * 0.46;

    final paint = Paint()
      ..color = AppColors.neonGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Upper arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 1.05,
      math.pi * 0.9,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
