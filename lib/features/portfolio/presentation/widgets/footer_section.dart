import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/hover_card.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/developer_profile.dart';

class FooterSection extends StatelessWidget {
  final DeveloperProfile profile;

  const FooterSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: EdgeInsets.only(
        top: isMobile ? 40 : 80,
        bottom: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HoverCard(
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            backgroundColor: const Color(0xFF0D0D10),
            borderColor: AppColors.borderBright,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '05 / DIRECT COLLABORATION',
                  style: AppTypography.mono(
                    fontSize: 12,
                    color: AppColors.flutterCyan,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'LET’S BUILD HIGH-IMPACT APPS.',
                  style: AppTypography.displayBold(
                    fontSize: isMobile ? 28 : 42,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Text(
                    'Open for full-time Senior Flutter Developer roles, architectural consulting, or leading greenfield cross-platform product launches.',
                    style: AppTypography.sans(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Quick Profile Summary Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141418),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'QUICK PROFILE SUMMARY',
                        style: AppTypography.mono(
                          fontSize: 11,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 10,
                        children: [
                          _SummaryPill(
                            label: 'Location',
                            value: 'India (Remote Ready)',
                          ),
                          _SummaryPill(
                            label: 'Notice',
                            value: profile.noticePeriod,
                            highlightColor: AppColors.emeraldLive,
                          ),
                          _SummaryPill(
                            label: 'Target CTC',
                            value: profile.targetCTC,
                            highlightColor: AppColors.flutterCyan,
                          ),
                          _SummaryPill(
                            label: 'Core',
                            value: 'Flutter, Dart, BLoC, WebSockets, FCM',
                          ),
                          const _SummaryPill(
                            label: 'Open-Source',
                            value: 'Continuous Supporter & Author',
                            highlightColor: Color(0xFFFBBF24),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Call to Action Buttons
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    PrimaryButton(
                      label: 'SEND EMAIL DIRECTLY',
                      variant: ButtonVariant.primary,
                      icon: Icons.mail_outline,
                      showArrow: false,
                      onPressed: () => UrlLauncherHelper.launchEmail(
                        profile.contactLinks['email'] ?? AppStrings.emailAddress,
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
                      label: 'LINKEDIN',
                      variant: ButtonVariant.outline,
                      onPressed: () => UrlLauncherHelper.launchURL(
                        profile.contactLinks['linkedin'] ?? AppStrings.linkedinUrl,
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
                      label: 'WHATSAPP',
                      variant: ButtonVariant.subtle,
                      icon: Icons.chat_bubble_outline,
                      showArrow: false,
                      onPressed: () => UrlLauncherHelper.launchWhatsApp(
                        profile.contactLinks['phone'] ?? AppStrings.phoneNumber,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Bottom Copyright & Brand tag
          const Divider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '© ${DateTime.now().year} Nithin TA. Senior Flutter Developer. All rights reserved.',
                  style: AppTypography.mono(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
              if (isDesktop)
                const Wrap(
                  spacing: 8,
                  children: [
                    BadgeChip(
                      label: 'CONTINUOUS OPEN-SOURCE SUPPORTER',
                      backgroundColor: Color(0xFF1B1910),
                      textColor: Color(0xFFFBBF24),
                      borderColor: Color(0x40FBBF24),
                    ),
                    BadgeChip(
                      label: 'FLUTTER / DART SPECIALIST',
                      backgroundColor: Color(0xFF111116),
                      textColor: AppColors.textSecondary,
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  final String label;
  final String value;
  final Color? highlightColor;

  const _SummaryPill({
    required this.label,
    required this.value,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '• $label: ',
          style: AppTypography.mono(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
        Text(
          value,
          style: AppTypography.monoBold(
            fontSize: 12,
            color: highlightColor ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
