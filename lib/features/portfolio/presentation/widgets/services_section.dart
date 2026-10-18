import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
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
          Center(
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
          const SizedBox(height: 48),

          // 3-Card Grid with Center Highlighted Card
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildDarkCard(
                    icon: Icons.architecture,
                    title: 'Mobile Architecture',
                    description:
                        'Clean Architecture, SOLID principles, testable repository patterns, and modular codebase engineering designed for hyper-scale expansion.',
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildFeaturedGreenCard(
                    icon: Icons.developer_mode,
                    title: 'Development & Real-Time',
                    description:
                        'End-to-end Flutter development. Socket.IO live bidirectional chat, sub-second latency messaging, Google Maps live location tracking, and 120 FPS UI.',
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildDarkCard(
                    icon: Icons.cloud_sync,
                    title: 'Cloud, Payments & Stores',
                    description:
                        'Firebase integration (FCM, Firestore, Auth), payment gateways (Razorpay, Stripe, IAP), and seamless Play Store & App Store release lifecycle governance.',
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                _buildDarkCard(
                  icon: Icons.architecture,
                  title: 'Mobile Architecture',
                  description:
                      'Clean Architecture, SOLID principles, testable repository patterns, and modular codebase engineering designed for hyper-scale expansion.',
                ),
                const SizedBox(height: 20),
                _buildFeaturedGreenCard(
                  icon: Icons.developer_mode,
                  title: 'Development & Real-Time',
                  description:
                      'End-to-end Flutter development. Socket.IO live bidirectional chat, sub-second latency messaging, Google Maps live location tracking, and 120 FPS UI.',
                ),
                const SizedBox(height: 20),
                _buildDarkCard(
                  icon: Icons.cloud_sync,
                  title: 'Cloud, Payments & Stores',
                  description:
                      'Firebase integration (FCM, Firestore, Auth), payment gateways (Razorpay, Stripe, IAP), and seamless Play Store & App Store release lifecycle governance.',
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
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF111114),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF27272A), width: 1.2),
      ),
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
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.neonGreen,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonGreen.withValues(alpha: 0.35),
            blurRadius: 36,
            offset: const Offset(0, 8),
          ),
        ],
      ),
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
