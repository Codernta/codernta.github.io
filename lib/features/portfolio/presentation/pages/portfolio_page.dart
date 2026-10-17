import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/cyber_dots_painter.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/navbar_widget.dart';
import '../widgets/open_source_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/timeline_experience_section.dart';
import '../widgets/why_hire_section.dart';

class PortfolioPage extends StatefulWidget {
  final PortfolioController controller;

  const PortfolioPage({super.key, required this.controller});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadPortfolio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final status = widget.controller.status;

          if (status == PortfolioStatus.loading ||
              status == PortfolioStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.flutterCyan,
              ),
            );
          }

          if (status == PortfolioStatus.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.terminalRed,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading portfolio data',
                    style: AppTypography.displayBold(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.controller.errorMessage ?? 'Unknown error',
                    style: AppTypography.mono(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => widget.controller.loadPortfolio(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final data = widget.controller.data!;

          return Stack(
            children: [
              // Subtle Cyber Dots Background
              Positioned.fill(
                child: CustomPaint(
                  painter: CyberDotsPainter(),
                ),
              ),

              // Main Scrollable Portfolio Body
              SingleChildScrollView(
                controller: widget.controller.scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 68), // Offset for floating navbar
                    Center(
                      child: Container(
                        width: ResponsiveLayout.contentWidth(context),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            HeroSection(
                              profile: data.profile,
                              controller: widget.controller,
                            ),
                            OpenSourceSection(
                              packages: data.openSourcePackages,
                              controller: widget.controller,
                            ),
                            TimelineExperienceSection(
                              profile: data.profile,
                              skills: data.skills,
                              controller: widget.controller,
                            ),
                            ProjectsSection(
                              projects: data.projects,
                              controller: widget.controller,
                            ),
                            WhyHireSection(
                              profile: data.profile,
                              controller: widget.controller,
                            ),
                            FooterSection(
                              profile: data.profile,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Floating Sticky Glassmorphism Navbar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: NavbarWidget(controller: widget.controller),
              ),
            ],
          );
        },
      ),
    );
  }
}
