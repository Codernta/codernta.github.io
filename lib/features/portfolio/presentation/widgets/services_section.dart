import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/cyber_interactive_card.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../controllers/portfolio_controller.dart';

class ServicesSection extends StatelessWidget {
  final PortfolioController controller;

  const ServicesSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: controller.servicesKey,
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
                    '// DOMAIN EXPERTISE',
                    style: AppTypography.monoBold(
                      fontSize: 11,
                      color: AppColors.neonGreen,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Services',
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
                      'Comprehensive mobile engineering capabilities for startups and enterprise platforms.',
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

          // 3-Card Grid with Center Highlighted Card & Staggered Scroll Entrance
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 100),
                    child: _buildDarkCard(
                      icon: Icons.architecture,
                      title: 'Mobile Architecture',
                      description:
                          'Clean Architecture, SOLID principles, testable repository patterns, and modular codebase engineering designed for hyper-scale expansion.',
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 200),
                    child: _buildFeaturedGreenCard(
                      icon: Icons.developer_mode,
                      title: 'Development & Real-Time',
                      description:
                          'End-to-end Flutter development. Socket.IO live bidirectional chat, sub-second latency messaging, Google Maps live location tracking, and 120 FPS UI.',
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 300),
                    child: _buildDarkCard(
                      icon: Icons.cloud_sync,
                      title: 'Cloud, Payments & Stores',
                      description:
                          'Firebase integration (FCM, Firestore, Auth), payment gateways (Razorpay, Stripe, IAP), and seamless Play Store & App Store release lifecycle governance.',
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                ScrollReveal(
                  child: _buildDarkCard(
                    icon: Icons.architecture,
                    title: 'Mobile Architecture',
                    description:
                        'Clean Architecture, SOLID principles, testable repository patterns, and modular codebase engineering designed for hyper-scale expansion.',
                  ),
                ),
                const SizedBox(height: 20),
                ScrollReveal(
                  delay: const Duration(milliseconds: 150),
                  child: _buildFeaturedGreenCard(
                    icon: Icons.developer_mode,
                    title: 'Development & Real-Time',
                    description:
                        'End-to-end Flutter development. Socket.IO live bidirectional chat, sub-second latency messaging, Google Maps live location tracking, and 120 FPS UI.',
                  ),
                ),
                const SizedBox(height: 20),
                ScrollReveal(
                  delay: const Duration(milliseconds: 300),
                  child: _buildDarkCard(
                    icon: Icons.cloud_sync,
                    title: 'Cloud, Payments & Stores',
                    description:
                        'Firebase integration (FCM, Firestore, Auth), payment gateways (Razorpay, Stripe, IAP), and seamless Play Store & App Store release lifecycle governance.',
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDarkCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return CyberInteractiveCard(
      padding: const EdgeInsets.all(32),
      borderRadius: 20,
      enableTilt: true,
      maxTilt: 0.05,
      liftOffset: -6,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF18181B),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF27272A)),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: AppColors.neonGreen, size: 26),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.displayBold(
              fontSize: 19,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTypography.mono(
              fontSize: 12.5,
              color: const Color(0xFFA1A1AA),
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedGreenCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return CyberInteractiveCard(
      padding: const EdgeInsets.all(32),
      borderRadius: 20,
      backgroundColor: AppColors.neonGreen,
      borderColor: AppColors.neonGreen,
      hoverBorderColor: Colors.white,
      enableTilt: true,
      maxTilt: 0.05,
      liftOffset: -8,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: AppColors.neonGreen, size: 26),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.displayBold(
              fontSize: 19,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTypography.monoBold(
              fontSize: 12.5,
              color: const Color(0xDD000000),
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
