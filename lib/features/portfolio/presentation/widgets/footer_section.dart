import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../domain/entities/developer_profile.dart';

class FooterSection extends StatelessWidget {
  final DeveloperProfile profile;

  const FooterSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.neonGreen,
        border: Border(
          top: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 36 : 48,
        horizontal: isMobile ? 20 : 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 4 Columns Grid
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildUsefulLinks(context)),
                    Expanded(child: _buildTechnicalStack(context)),
                    Expanded(child: _buildContactInfo(context)),
                    Expanded(child: _buildBrandSummary(context)),
                  ],
                )
              else
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    SizedBox(
                      width: isMobile ? double.infinity : 280,
                      child: _buildUsefulLinks(context),
                    ),
                    SizedBox(
                      width: isMobile ? double.infinity : 280,
                      child: _buildTechnicalStack(context),
                    ),
                    SizedBox(
                      width: isMobile ? double.infinity : 280,
                      child: _buildContactInfo(context),
                    ),
                    SizedBox(
                      width: isMobile ? double.infinity : 280,
                      child: _buildBrandSummary(context),
                    ),
                  ],
                ),
              const SizedBox(height: 36),

              // Divider
              Container(
                height: 1,
                color: Colors.black.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 20),

              // Copyright
              Text(
                '© Copyright 2025 Nithin T A. All rights reserved. Senior Flutter Developer.',
                textAlign: TextAlign.center,
                style: AppTypography.monoBold(
                  fontSize: 11,
                  color: const Color(0xCC000000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsefulLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'USEFUL LINK',
          style: AppTypography.displayBold(
            fontSize: 13,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        _buildFooterLink('About Me', () {}),
        _buildFooterLink('Core Capabilities', () {}),
        _buildFooterLink('Live Projects', () {}),
        _buildFooterLink('Pub.dev Package', () {
          UrlLauncherHelper.launchUrl('https://pub.dev/packages/bharat_fx');
        }),
      ],
    );
  }

  Widget _buildTechnicalStack(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TECHNICAL STACK',
          style: AppTypography.displayBold(
            fontSize: 13,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        _buildFooterItem('Flutter & Dart SDK'),
        _buildFooterItem('BLoC, GetX & Clean Arch'),
        _buildFooterItem('WebSockets & Socket.IO'),
        _buildFooterItem('Google Maps & Geofencing'),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONTACT INFO',
          style: AppTypography.displayBold(
            fontSize: 13,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        _buildFooterItem('+91 80757 76122'),
        _buildFooterItem('codernta@gmail.com'),
        _buildFooterItem('India (Global Remote / Onsite)'),
      ],
    );
  }

  Widget _buildBrandSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'NITHIN T A',
              style: AppTypography.displayBold(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Senior Flutter Developer with 4+ years of real-world production mobile app delivery. Ready to join immediately with 0 days notice.',
          style: AppTypography.mono(
            fontSize: 11,
            color: const Color(0xCC000000),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: AppTypography.mono(
          fontSize: 12,
          color: const Color(0xDD000000),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFooterLink(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          label,
          style: AppTypography.mono(
            fontSize: 12,
            color: const Color(0xDD000000),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
