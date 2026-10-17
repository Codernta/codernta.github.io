import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../../../core/widgets/hover_card.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/developer_profile.dart';
import '../controllers/portfolio_controller.dart';

class HeroSection extends StatelessWidget {
  final DeveloperProfile profile;
  final PortfolioController controller;

  const HeroSection({
    super.key,
    required this.profile,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: controller.heroKey,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Taglines Row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  profile.companyHighlights.isNotEmpty
                      ? AppStrings.heroTagline
                      : '// SENIOR MOBILE ENGINEER',
                  style: AppTypography.mono(
                    fontSize: 12,
                    color: AppColors.flutterCyan,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1910),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0x60FBBF24)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🌟 ', style: TextStyle(fontSize: 12)),
                    Text(
                      'CONTINUOUS OPEN-SOURCE SUPPORTER',
                      style: AppTypography.monoBold(
                        fontSize: 11,
                        color: const Color(0xFFFBBF24),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Big Headline: FLUTTER DEVELOPER
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FLUTTER',
                  style: AppTypography.displayExtraBold(
                    fontSize: isMobile ? 64 : 110,
                    color: Colors.white,
                    letterSpacing: -2.0,
                  ),
                ),
                Text(
                  'DEVELOPER',
                  style: TextStyle(
                    fontFamily: AppTypography.displayExtraBold().fontFamily,
                    fontSize: isMobile ? 64 : 110,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2.0,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = isMobile ? 2.0 : 2.5
                      ..color = const Color(0xFF54C5F8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Subtitle info line
          Text(
            profile.subtitle,
            style: AppTypography.mono(
              fontSize: isMobile ? 13 : 15,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 36),

          // Availability & Bio Highlight Card
          HoverCard(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Status Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'AVAILABILITY STATUS',
                      style: AppTypography.monoBold(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.emeraldLive.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.emeraldLive.withOpacity(0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.emeraldLive,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            profile.availabilityStatus,
                            style: AppTypography.monoBold(
                              fontSize: 11,
                              color: AppColors.emeraldLive,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Bio
                Text(
                  profile.bio,
                  style: AppTypography.sans(
                    fontSize: isMobile ? 15 : 18,
                    color: AppColors.textPrimary,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),

                // Metrics / Notice / CTC row
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _InfoBadge(
                      label: 'NOTICE PERIOD',
                      value: profile.noticePeriod,
                      highlightColor: AppColors.flutterCyan,
                    ),
                    _InfoBadge(
                      label: 'TARGET CTC',
                      value: profile.targetCTC,
                      highlightColor: AppColors.emeraldLive,
                    ),
                    _InfoBadge(
                      label: 'CURRENT CTC',
                      value: profile.currentCTC,
                    ),
                    _InfoBadge(
                      label: 'WORK PREFERENCE',
                      value: profile.workPreference,
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Stats Boxes Row
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _StatBox(
                      number: profile.stats['years'] ?? '4+',
                      label: profile.stats['yearsLabel'] ?? 'Years Exp',
                    ),
                    _StatBox(
                      number: profile.stats['apps'] ?? '5+',
                      label: profile.stats['appsLabel'] ?? 'Live Apps',
                    ),
                    _StatBox(
                      number: profile.stats['pkg'] ?? '1',
                      label: profile.stats['pkgLabel'] ?? 'Pub.dev Pkg',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Bottom Action Row
          Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PrimaryButton(
                label: 'EXPLORE MY WORK ↓',
                variant: ButtonVariant.primary,
                showArrow: false,
                onPressed: () => controller.scrollToSection(
                  controller.projectsKey,
                  'projects',
                ),
              ),
              PrimaryButton(
                label: 'GITHUB',
                variant: ButtonVariant.outline,
                onPressed: () => UrlLauncherHelper.launchURL(
                  profile.contactLinks['github'] ?? AppStrings.githubUrl,
                ),
              ),
              PrimaryButton(
                label: 'LINKEDIN',
                variant: ButtonVariant.outline,
                onPressed: () => UrlLauncherHelper.launchURL(
                  profile.contactLinks['linkedin'] ?? AppStrings.linkedinUrl,
                ),
              ),
              PrimaryButton(
                label: 'MEDIUM BLOG',
                variant: ButtonVariant.outline,
                icon: Icons.article_outlined,
                showArrow: false,
                onPressed: () => UrlLauncherHelper.launchURL(
                  profile.contactLinks['medium'] ?? AppStrings.mediumUrl,
                ),
              ),
              PrimaryButton(
                label: 'PUB.DEV',
                variant: ButtonVariant.outline,
                onPressed: () => UrlLauncherHelper.launchURL(
                  profile.contactLinks['pubdev'] ?? AppStrings.pubDevUrl,
                ),
              ),
              PrimaryButton(
                label: 'PORTFOLIO',
                variant: ButtonVariant.subtle,
                onPressed: () => UrlLauncherHelper.launchURL(
                  profile.contactLinks['portfolio'] ?? AppStrings.portfolioUrl,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color? highlightColor;

  const _InfoBadge({
    required this.label,
    required this.value,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0C0F),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.mono(
              fontSize: 10,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.monoBold(
              fontSize: 13,
              color: highlightColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String number;
  final String label;

  const _StatBox({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF15151A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: AppTypography.displayBold(
              fontSize: 28,
              color: AppColors.flutterCyan,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.mono(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
