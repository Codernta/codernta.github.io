import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/hover_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/project_item.dart';
import '../controllers/portfolio_controller.dart';

class ProjectsSection extends StatelessWidget {
  final List<ProjectItem> projects;
  final PortfolioController controller;

  const ProjectsSection({
    super.key,
    required this.projects,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: controller.projectsKey,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            label: '03 / VERIFIED WORK',
            title: 'LIVE PRODUCTION APPS',
            subtitle:
                'Real-world mobile apps built from scratch, architected for high scale, and running in production.',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.emeraldLive.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.emeraldLive.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.emeraldLive,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${projects.length} Apps Live on Google Play',
                    style: AppTypography.monoBold(
                      fontSize: 11,
                      color: AppColors.emeraldLive,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 36),

          // Layout: 2-column grid for desktop, 1-column for tablet and mobile
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isDesktop ? 2 : 1;
              final itemWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 20)) / crossAxisCount;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: projects.map((item) {
                  return SizedBox(
                    width: itemWidth,
                    child: _ProjectCard(item: item),
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

class _ProjectCard extends StatefulWidget {
  final ProjectItem item;

  const _ProjectCard({required this.item});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      padding: const EdgeInsets.all(24),
      onTap: () => UrlLauncherHelper.launchURL(widget.item.playStoreUrl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Index & Live status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.item.indexLabel,
                      style: AppTypography.mono(
                        fontSize: 11,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (widget.item.isLive) BadgeChip.liveIndicator(),
                ],
              ),
              const SizedBox(height: 12),

              // Title & Subtitle
              MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.title,
                      style: AppTypography.displayBold(
                        fontSize: 24,
                        color: _isHovered ? AppColors.flutterCyan : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.item.subtitle,
                      style: AppTypography.mono(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Description
              Text(
                widget.item.description,
                style: AppTypography.sans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 18),

              // Tags
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.item.tags
                    .map((t) => BadgeChip(label: t))
                    .toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Bottom Bar
          Column(
            children: [
              const Divider(),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BadgeChip.verified(label: widget.item.verificationBadge),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'PLAY STORE',
                        style: AppTypography.monoBold(
                          fontSize: 11,
                          color: AppColors.flutterCyan,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '↗',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.flutterCyan,
                        ),
                      ),
                    ],
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
