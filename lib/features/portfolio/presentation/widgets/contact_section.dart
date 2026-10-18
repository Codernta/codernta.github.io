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

class ContactSection extends StatefulWidget {
  final DeveloperProfile profile;
  final PortfolioController controller;

  const ContactSection({
    super.key,
    required this.profile,
    required this.controller,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    final subject = name.isNotEmpty
        ? 'Inquiry from $name (Senior Flutter Developer)'
        : 'Senior Flutter Developer Inquiry';

    final body = '''
From: $name ($email)

Message:
$message
''';

    UrlLauncherHelper.launchEmail(
      widget.profile.contactLinks['email'] ?? 'codernta@gmail.com',
      subject: subject,
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: widget.controller.contactKey,
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
                    '// DIRECT ACCESS',
                    style: AppTypography.monoBold(
                      fontSize: 11,
                      color: AppColors.neonGreen,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Get In Touch',
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
                      'Available for immediate hire (0 Notice). Reach out directly or send a message.',
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

          // 2-Column Grid
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 100),
                    child: _buildContactForm(context),
                  ),
                ),
                const SizedBox(width: 36),
                Expanded(
                  flex: 6,
                  child: ScrollReveal(
                    delay: const Duration(milliseconds: 200),
                    child: _buildRightContactCards(context),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                ScrollReveal(
                  child: _buildContactForm(context),
                ),
                const SizedBox(height: 36),
                ScrollReveal(
                  delay: const Duration(milliseconds: 150),
                  child: _buildRightContactCards(context),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return CyberInteractiveCard(
      padding: const EdgeInsets.all(28),
      borderRadius: 20,
      enableTilt: true,
      maxTilt: 0.03,
      liftOffset: -4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputLabel('YOUR NAME HERE'),
          _buildTextField(
            controller: _nameController,
            hintText: 'Enter your full name',
          ),
          const SizedBox(height: 18),
          _buildInputLabel('YOUR EMAIL HERE'),
          _buildTextField(
            controller: _emailController,
            hintText: 'name@company.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 18),
          _buildInputLabel('YOUR MESSAGE HERE'),
          _buildTextField(
            controller: _messageController,
            hintText: 'Discuss Flutter role, architecture, or project...',
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'SEND MESSAGE',
            variant: ButtonVariant.primary,
            showArrow: true,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            onPressed: _handleSend,
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: AppTypography.mono(
          fontSize: 11,
          color: const Color(0xFFA1A1AA),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF070708),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF27272A)),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: AppTypography.mono(
          fontSize: 13,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTypography.mono(
            fontSize: 12,
            color: const Color(0xFF52525B),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildRightContactCards(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Location Graphic Card matching Stitch
        CyberInteractiveCard(
          padding: const EdgeInsets.all(20),
          borderRadius: 20,
          enableTilt: true,
          maxTilt: 0.04,
          liftOffset: -5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.neonGreen),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonGreen.withValues(alpha: 0.3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const PulsingRadarDot(size: 6),
                        const SizedBox(width: 6),
                        Text(
                          'CURRENT BASE: INDIA',
                          style: AppTypography.monoBold(
                            fontSize: 10,
                            color: AppColors.neonGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'GLOBAL REMOTE READY',
                    style: AppTypography.mono(
                      fontSize: 11,
                      color: const Color(0xFFA1A1AA),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              // Pin Icon with pulsing glow
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.6),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.location_on, color: Colors.white, size: 26),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF111114),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: const Color(0xFF27272A)),
                ),
                child: Text(
                  'Remote / Hybrid / Relocation (Bangalore, Kochi, Chennai, etc.)',
                  style: AppTypography.mono(
                    fontSize: 11,
                    color: const Color(0xFFE4E4E7),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Bottom Strip
              Container(
                padding: const EdgeInsets.only(top: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFF1F1F24), width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Timezone: UTC +05:30 (IST)',
                      style: AppTypography.mono(
                        fontSize: 11,
                        color: const Color(0xFFA1A1AA),
                      ),
                    ),
                    Text(
                      'Notice: 0 Days',
                      style: AppTypography.monoBold(
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
        const SizedBox(height: 16),

        // 4 Quick Contact Pills Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.2,
          children: [
            _buildContactPill(
              icon: Icons.mail_outline,
              label: 'DIRECT EMAIL',
              value: 'codernta@gmail.com',
              onTap: () => UrlLauncherHelper.launchEmail('codernta@gmail.com'),
            ),
            _buildContactPill(
              icon: Icons.phone_outlined,
              label: 'PHONE / WHATSAPP',
              value: '+91 80757 76122',
              onTap: () => UrlLauncherHelper.launchPhone('+918075776122'),
            ),
            _buildContactPill(
              icon: Icons.code,
              label: 'CODE REPOSITORY',
              value: 'github.com/codernta',
              onTap: () =>
                  UrlLauncherHelper.launchUrl('https://github.com/codernta'),
            ),
            _buildContactPill(
              icon: Icons.share,
              label: 'PROFESSIONAL',
              value: 'linkedin.com/in/codernta',
              onTap: () => UrlLauncherHelper.launchUrl(
                  'https://linkedin.com/in/codernta'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactPill({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return CyberInteractiveCard(
      onTap: onTap,
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      enableTilt: true,
      maxTilt: 0.03,
      liftOffset: -3,
      child: Row(
        children: [
          Icon(icon, color: AppColors.neonGreen, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: AppTypography.mono(
                    fontSize: 9,
                    color: const Color(0xFF71717A),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.monoBold(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
