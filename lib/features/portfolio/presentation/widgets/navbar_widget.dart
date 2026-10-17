import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controllers/portfolio_controller.dart';

class NavbarWidget extends StatelessWidget {
  final PortfolioController controller;

  const NavbarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary.withValues(alpha: 0.85),
            border: const Border(
              bottom: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand Logo & Title
                    InkWell(
                      onTap: () => controller.scrollToSection(
                        controller.heroKey,
                        'hero',
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        children: [
                          Text(
                            AppStrings.developerName.toUpperCase(),
                            style: AppTypography.displayBold(
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.flutterCyan.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.flutterCyan.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: AppColors.flutterCyan,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'FLUTTER DEV',
                                  style: AppTypography.monoBold(
                                    fontSize: 10,
                                    color: AppColors.flutterCyan,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Center Nav Links (Desktop)
                    if (isDesktop)
                      Row(
                        children: [
                          _NavLink(
                            label: AppStrings.navWork,
                            isActive: controller.activeSection == 'hero',
                            onTap: () => controller.scrollToSection(
                              controller.heroKey,
                              'hero',
                            ),
                          ),
                          _NavLink(
                            label: AppStrings.navOpenSource,
                            isActive: controller.activeSection == 'opensource',
                            onTap: () => controller.scrollToSection(
                              controller.openSourceKey,
                              'opensource',
                            ),
                          ),
                          _NavLink(
                            label: AppStrings.navTimeline,
                            isActive: controller.activeSection == 'timeline',
                            onTap: () => controller.scrollToSection(
                              controller.timelineKey,
                              'timeline',
                            ),
                          ),
                          _NavLink(
                            label: AppStrings.navApps,
                            isActive: controller.activeSection == 'projects',
                            onTap: () => controller.scrollToSection(
                              controller.projectsKey,
                              'projects',
                            ),
                          ),
                          _NavLink(
                            label: AppStrings.navContact,
                            isActive: controller.activeSection == 'contact',
                            onTap: () => controller.scrollToSection(
                              controller.contactKey,
                              'contact',
                            ),
                          ),
                        ],
                      ),

                    // Right CTA
                    PrimaryButton(
                      label: isDesktop ? AppStrings.navHireMe : 'HIRE (0d)',
                      variant: ButtonVariant.primary,
                      showArrow: true,
                      onPressed: () => controller.scrollToSection(
                        controller.contactKey,
                        'contact',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isActive
        ? AppColors.flutterCyan
        : (_isHovered ? Colors.white : AppColors.textSecondary);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            widget.label,
            style: AppTypography.mono(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
