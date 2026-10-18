import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../../../core/widgets/cyber_interactive_card.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/pulsing_radar_dot.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../domain/entities/developer_profile.dart';
import '../controllers/portfolio_controller.dart';

class AboutSection extends StatelessWidget {
  final DeveloperProfile profile;
  final PortfolioController controller;

  const AboutSection({
    super.key,
    required this.profile,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: controller.aboutKey,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 36 : 64,
        horizontal: isMobile ? 12 : 24,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: ScrollReveal(
                    child: _buildPortraitCard(context, isMobile: false),
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 7,
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 150),
                    child: _buildAboutContent(context, isMobile: false),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ScrollReveal(
                  child: _buildPortraitCard(context, isMobile: true),
                ),
                const SizedBox(height: 36),
                ScrollReveal(
                  delay: const Duration(milliseconds: 150),
                  child: _buildAboutContent(context, isMobile: true),
                ),
              ],
            ),
    );
  }

  Widget _buildPortraitCard(BuildContext context, {required bool isMobile}) {
    return CyberInteractiveCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 24,
      enableTilt: true,
      maxTilt: 0.04,
      liftOffset: -6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Header Pill in Card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.neonGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: AppColors.neonGreen.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const PulsingRadarDot(size: 6),
                    const SizedBox(width: 6),
                    Text(
                      'AVAILABLE IMMEDIATELY',
                      style: AppTypography.monoBold(
                        fontSize: 10,
                        color: AppColors.neonGreen,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '0 NOTICE',
                style: AppTypography.mono(
                  fontSize: 11,
                  color: const Color(0xFFA1A1AA),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Photo Frame
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1.05,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/nithin_profile.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/nithin_cutout.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  // Dark Vignette Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.75),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 14,
                    right: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'NITHIN T A',
                          style: AppTypography.displayBold(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Senior Mobile Solutions Architect',
                          style: AppTypography.mono(
                            fontSize: 11,
                            color: AppColors.neonGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Compensation & Notice Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF070708),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF1F1F24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT CTC',
                      style: AppTypography.mono(
                        fontSize: 9,
                        color: const Color(0xFF71717A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profile.currentCTC.isNotEmpty ? profile.currentCTC : '₹6.5 LPA',
                      style: AppTypography.monoBold(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: const Color(0xFF27272A),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TARGET CTC',
                      style: AppTypography.mono(
                        fontSize: 9,
                        color: const Color(0xFF71717A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profile.targetCTC.isNotEmpty ? profile.targetCTC : '₹8.0 LPA',
                      style: AppTypography.monoBold(
                        fontSize: 12,
                        color: AppColors.neonGreen,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: const Color(0xFF27272A),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOCATION',
                      style: AppTypography.mono(
                        fontSize: 9,
                        color: const Color(0xFF71717A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'India (Remote)',
                      style: AppTypography.monoBold(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Label
        Row(
          children: [
            Container(
              width: 8,
              height: 2,
              color: AppColors.neonGreen,
            ),
            const SizedBox(width: 8),
            Text(
              '// ARCHITECTURE & BACKGROUND',
              style: AppTypography.monoBold(
                fontSize: 11,
                color: AppColors.neonGreen,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Headline
        Text(
          'High-Performance Cross-Platform Engineering',
          style: AppTypography.displayBold(
            fontSize: isMobile ? 26 : 38,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 18),

        // Bio copy
        Text(
          'I am a Senior Flutter Developer with 4+ years of professional engineering experience shipping scalable, responsive, and resilient mobile applications for Android and iOS.',
          style: AppTypography.sans(
            fontSize: 15,
            color: const Color(0xFFE4E4E7),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'My expertise spans Clean Architecture, strict SOLID principles, BLoC and GetX state management, low-latency Socket.IO communications, background geofencing via Google Maps Platform, OpenAI API integrations, BLE hardware protocols, and automated CI/CD release lifecycles.',
          style: AppTypography.sans(
            fontSize: 14,
            color: const Color(0xFFA1A1AA),
            height: 1.65,
          ),
        ),
        const SizedBox(height: 28),

        // 4-Box Metadata Grid with interactive cards
        GridView.count(
          crossAxisCount: isMobile ? 2 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: isMobile ? 2.3 : 2.8,
          children: [
            _buildMetaBox('ROLE', 'Senior Flutter Dev'),
            _buildMetaBox('AVAILABILITY', '0 Days (Immediate)'),
            _buildMetaBox('EXPERIENCE', '4+ Years Production'),
            _buildMetaBox('LOCATION', 'India (Global Remote)'),
          ],
        ),
        const SizedBox(height: 32),

        // Action Buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            PrimaryButton(
              label: 'DOWNLOAD CV / RESUME',
              variant: ButtonVariant.primary,
              showArrow: true,
              onPressed: () => UrlLauncherHelper.launchEmail(
                'codernta@gmail.com',
                subject: 'Resume Request - Senior Flutter Developer',
              ),
            ),
            PrimaryButton(
              label: 'GET IN TOUCH',
              variant: ButtonVariant.outline,
              showArrow: false,
              onPressed: () => controller.scrollToSection(
                controller.contactKey,
                'contact',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetaBox(String label, String value) {
    return CyberInteractiveCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      borderRadius: 12,
      enableTilt: true,
      maxTilt: 0.03,
      liftOffset: -3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTypography.mono(
              fontSize: 10,
              color: const Color(0xFF71717A),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: AppTypography.monoBold(
              fontSize: 12.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
