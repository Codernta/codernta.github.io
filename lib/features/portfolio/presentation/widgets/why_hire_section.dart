import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/hover_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/developer_profile.dart';
import '../controllers/portfolio_controller.dart';
import 'terminal_contact_widget.dart';

class WhyHireSection extends StatelessWidget {
  final DeveloperProfile profile;
  final PortfolioController controller;

  const WhyHireSection({
    super.key,
    required this.profile,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: controller.contactKey,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: '04 / WHY HIRE NITHIN TA',
            title: 'PROVEN RESULTS. ZERO ONBOARDING FRICTION.',
            subtitle:
                'Bringing 4+ years of real-world mobile app shipping experience. I take features from raw Figma mockups through scalable architecture all the way to Play Store approval and production user monitoring.',
          ),
          const SizedBox(height: 24),

          // Instant Deployment Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.emeraldLive.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.emeraldLive.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  '⚡',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppTypography.sans(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        TextSpan(
                          text: 'Instant Deployment Readiness: ',
                          style: AppTypography.sansBold(
                            fontSize: 14,
                            color: AppColors.emeraldLive,
                          ),
                        ),
                        const TextSpan(
                          text:
                              'Notice period: 0 Days. Able to start immediately on full-time remote, hybrid, or on-site roles.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // 4 Pillars Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isDesktop ? 2 : 1;
              final width = (constraints.maxWidth - ((crossAxisCount - 1) * 20)) /
                  crossAxisCount;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  SizedBox(
                    width: width,
                    child: const _PillarCard(
                      indexLabel: '01 / ARCHITECTURE',
                      title: 'Clean, Modular Code',
                      description:
                          'Strict domain-driven layering. Testable repository patterns, immutable entity models, and minimal widget rebuilding with robust state isolation.',
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: const _PillarCard(
                      indexLabel: '02 / PERFORMANCE',
                      title: '60 & 120 FPS Fluidity',
                      description:
                          'DevTools memory profiling, image caching optimization, shader warm-up, and jank prevention for silky smooth animations and rapid startup.',
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: const _PillarCard(
                      indexLabel: '03 / END-TO-END',
                      title: 'Deployment & Release',
                      description:
                          'Expertise in Google Play Vitals, Apple Review compliance, signing keys, Fastlane automation, and automated store listings.',
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: const _PillarCard(
                      indexLabel: '04 / COLLABORATION',
                      title: 'Remote Proven',
                      description:
                          'Extensive experience working in distributed teams with asynchronous communication, Jira, GitHub PR reviews, and Slack.',
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 40),

          // Terminal Contact Window
          TerminalContactWidget(
            email: profile.contactLinks['email'] ?? 'codernta@gmail.com',
            phone: profile.contactLinks['phone'] ?? '+91 80757 76122',
            portfolioUrl: profile.contactLinks['portfolio'] ??
                'https://codernta.lovable.app',
            mediumUrl: profile.contactLinks['medium'] ??
                'https://medium.com/@codernta',
            resumeUrl: profile.contactLinks['resume'],
          ),
        ],
      ),
    );
  }
}

class _PillarCard extends StatelessWidget {
  final String indexLabel;
  final String title;
  final String description;

  const _PillarCard({
    required this.indexLabel,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            indexLabel,
            style: AppTypography.mono(
              fontSize: 11,
              color: AppColors.flutterCyan,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTypography.displayBold(
              fontSize: 19,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTypography.sans(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
