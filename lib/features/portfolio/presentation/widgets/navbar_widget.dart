import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/pulsing_radar_dot.dart';
import '../controllers/portfolio_controller.dart';

class NavbarWidget extends StatelessWidget {
  final PortfolioController controller;

  const NavbarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF070708).withValues(alpha: 0.92),
            border: const Border(
              bottom: BorderSide(color: Color(0xFF18181B), width: 1),
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1280),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Brand Logo with Pulsing Cyber Radar Beacon
                        InkWell(
                          onTap: () => controller.scrollToSection(
                            controller.heroKey,
                            'hero',
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const PulsingRadarDot(size: 8),
                              const SizedBox(width: 8),
                              Text(
                                'NITHIN T A',
                                style: AppTypography.displayBold(
                                  fontSize: 16,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              if (!isMobile) ...[
                                const SizedBox(width: 8),
                                Text(
                                  '// SENIOR FLUTTER DEV',
                                  style: AppTypography.mono(
                                    fontSize: 10,
                                    color: AppColors.textMuted,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Nav Links (Desktop) with Smooth Indicators
                        if (isDesktop)
                          Row(
                            children: [
                              _NavLink(
                                label: 'Home',
                                isActive: controller.activeSection == 'hero',
                                onTap: () => controller.scrollToSection(
                                  controller.heroKey,
                                  'hero',
                                ),
                              ),
                              _NavLink(
                                label: 'About',
                                isActive: controller.activeSection == 'about',
                                onTap: () => controller.scrollToSection(
                                  controller.aboutKey,
                                  'about',
                                ),
                              ),
                              _NavLink(
                                label: 'Skills',
                                isActive: controller.activeSection == 'skills',
                                onTap: () => controller.scrollToSection(
                                  controller.skillsKey,
                                  'skills',
                                ),
                              ),
                              _NavLink(
                                label: 'Services',
                                isActive: controller.activeSection == 'services',
                                onTap: () => controller.scrollToSection(
                                  controller.servicesKey,
                                  'services',
                                ),
                              ),
                              _NavLink(
                                label: 'Portfolio',
                                isActive: controller.activeSection == 'projects',
                                onTap: () => controller.scrollToSection(
                                  controller.projectsKey,
                                  'projects',
                                ),
                              ),
                              _NavLink(
                                label: 'Contact',
                                isActive: controller.activeSection == 'contact',
                                onTap: () => controller.scrollToSection(
                                  controller.contactKey,
                                  'contact',
                                ),
                              ),
                            ],
                          ),

                        // Right Neon Pill Action: Hire Me
                        _HireMePill(
                          isMobile: isMobile,
                          onTap: () => controller.scrollToSection(
                            controller.contactKey,
                            'contact',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Animated Scroll Progress Bar at the bottom edge of Navbar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: controller.scrollController,
                  builder: (context, _) {
                    double progress = 0.0;
                    if (controller.scrollController.hasClients) {
                      final pos = controller.scrollController.position;
                      if (pos.hasContentDimensions && pos.maxScrollExtent > 0) {
                        progress = (pos.pixels / pos.maxScrollExtent)
                            .clamp(0.0, 1.0);
                      }
                    }
                    return FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppColors.neonGreen,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.neonGreen.withValues(alpha: 0.8),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
        ? AppColors.neonGreen
        : (_isHovered ? Colors.white : const Color(0xFFA1A1AA));

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTypography.mono(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              // Animated Indicator Line
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.isActive ? 18.0 : (_isHovered ? 12.0 : 0.0),
                height: 2,
                decoration: BoxDecoration(
                  color: widget.isActive
                      ? AppColors.neonGreen
                      : Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: widget.isActive
                      ? [
                          BoxShadow(
                            color: AppColors.neonGreen.withValues(alpha: 0.8),
                            blurRadius: 6,
                          ),
                        ]
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HireMePill extends StatefulWidget {
  final bool isMobile;
  final VoidCallback onTap;

  const _HireMePill({required this.isMobile, required this.onTap});

  @override
  State<_HireMePill> createState() => _HireMePillState();
}

class _HireMePillState extends State<_HireMePill> {
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
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 14 : 20,
            vertical: widget.isMobile ? 7 : 9,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.neonGreenHover : AppColors.neonGreen,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.neonGreen.withValues(alpha: 0.6)
                    : AppColors.neonGreen.withValues(alpha: 0.35),
                blurRadius: _isHovered ? 20 : 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.isMobile ? 'HIRE ME' : 'HIRE ME (0 NOTICE)',
                style: AppTypography.monoBold(
                  fontSize: 11,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 4),
              AnimatedSlide(
                offset: _isHovered ? const Offset(0.15, -0.15) : Offset.zero,
                duration: const Duration(milliseconds: 180),
                child: const Text(
                  '↗',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
