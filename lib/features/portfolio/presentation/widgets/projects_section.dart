import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../domain/entities/project_item.dart';
import '../controllers/portfolio_controller.dart';

class ProjectsSection extends StatefulWidget {
  final List<ProjectItem> projects;
  final PortfolioController controller;

  const ProjectsSection({
    super.key,
    required this.projects,
    required this.controller,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Social & Chat',
    'Streaming',
    'Enterprise',
    'EdTech',
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    // Filter projects based on selected category
    final filteredProjects = widget.projects.where((p) {
      if (_selectedCategory == 'All') return true;
      if (_selectedCategory == 'Social & Chat') {
        return p.title.toLowerCase().contains('pet') ||
            p.description.toLowerCase().contains('chat') ||
            p.description.toLowerCase().contains('socket');
      }
      if (_selectedCategory == 'Streaming') {
        return p.title.toLowerCase().contains('mash') ||
            p.description.toLowerCase().contains('media') ||
            p.description.toLowerCase().contains('streaming');
      }
      if (_selectedCategory == 'Enterprise') {
        return p.title.toLowerCase().contains('demeter') ||
            p.title.toLowerCase().contains('fitout') ||
            p.title.toLowerCase().contains('dalil') ||
            p.description.toLowerCase().contains('enterprise');
      }
      if (_selectedCategory == 'EdTech') {
        return p.title.toLowerCase().contains('eduwizz') ||
            p.description.toLowerCase().contains('assessment');
      }
      return true;
    }).toList();

    return Container(
      key: widget.controller.projectsKey,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 36 : 64,
        horizontal: isMobile ? 12 : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Header
          Center(
            child: Column(
              children: [
                Text(
                  '// LIVE PRODUCTION APPS',
                  style: AppTypography.monoBold(
                    fontSize: 11,
                    color: AppColors.neonGreen,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Portfolio',
                  style: AppTypography.displayBold(
                    fontSize: isMobile ? 28 : 40,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: Text(
                    'Verified production mobile applications shipped directly to the Google Play Store.',
                    textAlign: TextAlign.center,
                    style: AppTypography.mono(
                      fontSize: 13,
                      color: const Color(0xFFA1A1AA),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Category Filter Pills
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: _categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.neonGreen.withValues(alpha: 0.15)
                              : const Color(0xFF111114),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.neonGreen
                                : const Color(0xFF27272A),
                          ),
                        ),
                        child: Text(
                          cat,
                          style: AppTypography.monoBold(
                            fontSize: 11,
                            color: isSelected
                                ? AppColors.neonGreen
                                : const Color(0xFFA1A1AA),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Projects Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isDesktop ? 3 : (constraints.maxWidth > 700 ? 2 : 1);
              final gap = 20.0;
              final itemWidth = (constraints.maxWidth - ((crossAxisCount - 1) * gap)) / crossAxisCount;

              final displayList = filteredProjects.isNotEmpty ? filteredProjects : widget.projects;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: displayList.map((item) {
                  return SizedBox(
                    width: itemWidth,
                    child: _StitchProjectCard(item: item),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StitchProjectCard extends StatefulWidget {
  final ProjectItem item;

  const _StitchProjectCard({required this.item});

  @override
  State<_StitchProjectCard> createState() => _StitchProjectCardState();
}

class _StitchProjectCardState extends State<_StitchProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: const Color(0xFF111114),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? AppColors.neonGreen.withValues(alpha: 0.8)
                : const Color(0xFF27272A),
            width: 1.2,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.neonGreen.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top index & badge row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.indexLabel.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.mono(
                            fontSize: 10,
                            color: const Color(0xFF71717A),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.neonGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'PLAY STORE',
                            style: AppTypography.monoBold(
                              fontSize: 10,
                              color: AppColors.neonGreen,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Project Title
                  Text(
                    item.title,
                    style: AppTypography.displayBold(
                      fontSize: 22,
                      color: _isHovered ? AppColors.neonGreen : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    item.subtitle,
                    style: AppTypography.sansMedium(
                      fontSize: 12,
                      color: const Color(0xFF71717A),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    item.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.mono(
                      fontSize: 12,
                      color: const Color(0xFFA1A1AA),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: item.tags.take(4).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF18181B),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFF27272A)),
                        ),
                        child: Text(
                          tag,
                          style: AppTypography.mono(
                            fontSize: 10,
                            color: const Color(0xFFD4D4D8),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Card Bottom Strip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF070708),
                border: Border(
                  top: BorderSide(color: Color(0xFF1F1F24), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Live Production App',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.mono(
                        fontSize: 11,
                        color: const Color(0xFF71717A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => UrlLauncherHelper.launchUrl(item.playStoreUrl),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Play Store',
                          style: AppTypography.monoBold(
                            fontSize: 11,
                            color: AppColors.neonGreen,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '↗',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.neonGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
