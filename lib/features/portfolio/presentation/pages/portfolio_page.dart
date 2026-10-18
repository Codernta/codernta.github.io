import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/cyber_ambient_background.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/navbar_widget.dart';
import '../widgets/open_source_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/services_section.dart';
import '../widgets/skills_radar_section.dart';
import '../widgets/testimonial_section.dart';
import '../widgets/timeline_experience_section.dart';
import '../widgets/vibrant_metrics_banner.dart';

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
      backgroundColor: const Color(0xFF050505),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final status = widget.controller.status;

          if (status == PortfolioStatus.loading ||
              status == PortfolioStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.neonGreen,
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
              // Interactive Cyber Ambient Backdrop (Dots + Dust Particles + Spotlight)
              Positioned.fill(
                child: CyberAmbientBackground(
                  child: SingleChildScrollView(
                    controller: widget.controller.scrollController,
                    child: Column(
                  children: [
                    const SizedBox(height: 64), // Offset for floating navbar

                    // 1. Hero Section
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: HeroSection(
                          profile: data.profile,
                          controller: widget.controller,
                        ),
                      ),
                    ),

                    // 2. Vibrant Full-Width Metrics Banner
                    const VibrantMetricsBanner(),

                    // 3. About Section
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: AboutSection(
                          profile: data.profile,
                          controller: widget.controller,
                        ),
                      ),
                    ),

                    // 4. Skills Radar Section
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: SkillsRadarSection(
                          skills: data.skills,
                          controller: widget.controller,
                        ),
                      ),
                    ),

                    // 5. Services Section
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: ServicesSection(
                          controller: widget.controller,
                        ),
                      ),
                    ),

                    // 6. Open Source Bharat FX Section
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: OpenSourceSection(
                          packages: data.openSourcePackages,
                          controller: widget.controller,
                        ),
                      ),
                    ),

                    // 7. Career Experience & Education Timeline
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: TimelineExperienceSection(
                          profile: data.profile,
                          experiences: data.experiences,
                          education: data.education,
                          skills: data.skills,
                          controller: widget.controller,
                        ),
                      ),
                    ),

                    // 8. Projects & Live Production Apps
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: ProjectsSection(
                          projects: data.projects,
                          controller: widget.controller,
                        ),
                      ),
                    ),

                    // 9. Testimonial Section
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: const TestimonialSection(),
                      ),
                    ),

                    // 10. Contact Section
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: ContactSection(
                          profile: data.profile,
                          controller: widget.controller,
                        ),
                      ),
                    ),

                    // 11. Vibrant Full-Width Footer
                    FooterSection(
                      profile: data.profile,
                    ),
                  ],
                ),
              ),
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
