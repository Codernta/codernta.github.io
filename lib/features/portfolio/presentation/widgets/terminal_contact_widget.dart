import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/url_launcher_helper.dart';

class TerminalContactWidget extends StatelessWidget {
  final String email;
  final String phone;
  final String portfolioUrl;
  final String? mediumUrl;

  const TerminalContactWidget({
    super.key,
    required this.email,
    required this.phone,
    required this.portfolioUrl,
    this.mediumUrl,
  });

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard: $text'),
        backgroundColor: AppColors.cardHover,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.terminalBody,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Terminal Top Title Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.terminalHeader,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
              border: Border(
                bottom: BorderSide(color: AppColors.border),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.terminalRed,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.terminalYellow,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.terminalGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  'terminal — nithin@developer:~\$',
                  style: AppTypography.mono(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // Terminal Body Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shell prompt line
                Row(
                  children: [
                    const Text(
                      '➜  ',
                      style: TextStyle(
                        color: AppColors.emeraldLive,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'contact-info',
                      style: AppTypography.monoBold(
                        fontSize: 13,
                        color: AppColors.flutterCyan,
                      ),
                    ),
                    Text(
                      ' --list-all',
                      style: AppTypography.mono(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Contact Items
                _TerminalRow(
                  label: 'EMAIL ADDRESS',
                  value: email,
                  actions: [
                    _TerminalButton(
                      label: 'Copy Email',
                      icon: Icons.copy,
                      onTap: () => _copyToClipboard(context, email, 'Email'),
                    ),
                    const SizedBox(width: 8),
                    _TerminalButton(
                      label: 'Send Email',
                      icon: Icons.send_rounded,
                      isPrimary: true,
                      onTap: () => UrlLauncherHelper.launchEmail(email),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _TerminalRow(
                  label: 'DIRECT PHONE / WHATSAPP',
                  value: phone,
                  actions: [
                    _TerminalButton(
                      label: 'Copy Phone',
                      icon: Icons.copy,
                      onTap: () => _copyToClipboard(context, phone, 'Phone'),
                    ),
                    const SizedBox(width: 8),
                    _TerminalButton(
                      label: 'WhatsApp',
                      icon: Icons.chat_bubble_outline,
                      isPrimary: true,
                      onTap: () => UrlLauncherHelper.launchWhatsApp(phone),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _TerminalRow(
                  label: 'WEB PORTFOLIO',
                  value: portfolioUrl,
                  actions: [
                    _TerminalButton(
                      label: 'Open URL ↗',
                      icon: Icons.open_in_new,
                      isPrimary: true,
                      onTap: () => UrlLauncherHelper.launchURL(portfolioUrl),
                    ),
                  ],
                ),
                if (mediumUrl != null) ...[
                  const SizedBox(height: 14),
                  _TerminalRow(
                    label: 'MEDIUM TECH WRITING & OPEN-SOURCE',
                    value: mediumUrl!,
                    actions: [
                      _TerminalButton(
                        label: 'Read Articles ↗',
                        icon: Icons.article_outlined,
                        isPrimary: true,
                        onTap: () => UrlLauncherHelper.launchURL(mediumUrl!),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TerminalRow extends StatelessWidget {
  final String label;
  final String value;
  final List<Widget> actions;

  const _TerminalRow({
    required this.label,
    required this.value,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF141418),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 450;
          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.mono(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTypography.monoBold(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(children: actions),
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.mono(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: AppTypography.monoBold(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(children: actions),
            ],
          );
        },
      ),
    );
  }
}

class _TerminalButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _TerminalButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  State<_TerminalButton> createState() => _TerminalButtonState();
}

class _TerminalButtonState extends State<_TerminalButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_isHovered
                    ? AppColors.flutterCyan
                    : AppColors.flutterCyan.withOpacity(0.15))
                : (_isHovered ? AppColors.border : const Color(0xFF1E1E24)),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: widget.isPrimary
                  ? AppColors.flutterCyan
                  : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 12,
                color: widget.isPrimary
                    ? (_isHovered ? Colors.black : AppColors.flutterCyan)
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: 5),
              Text(
                widget.label,
                style: AppTypography.mono(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: widget.isPrimary
                      ? (_isHovered ? Colors.black : AppColors.flutterCyan)
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
