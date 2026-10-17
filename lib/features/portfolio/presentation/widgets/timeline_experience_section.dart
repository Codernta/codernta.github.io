import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/hover_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/developer_profile.dart';
import '../../domain/entities/skill_category.dart';
import '../controllers/portfolio_controller.dart';

class TimelineExperienceSection extends StatelessWidget {
  final DeveloperProfile profile;
  final List<SkillCategory> skills;
  final PortfolioController controller;

  const TimelineExperienceSection({
    super.key,
    required this.profile,
    required this.skills,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: controller.timelineKey,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: '02 / PROFESSIONAL TIMELINE',
            title: 'ENGINEERING ROLES & CAPABILITIES',
            subtitle:
                'Production-grade software craftsmanship adhering strictly to SOLID, reactive data flow, and cross-platform platform channels.',
          ),
          const SizedBox(height: 32),

          // Two-column or Single-column layout
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Experience Timeline Card
                Expanded(
                  flex: 6,
                  child: _ExperienceCard(profile: profile),
                ),
                const SizedBox(width: 24),
                // Right 4 Skill Domain Cards Grid
                Expanded(
                  flex: 6,
                  child: _SkillsGrid(skills: skills),
                ),
              ],
            )
          else ...[
            _ExperienceCard(profile: profile),
            const SizedBox(height: 24),
            _SkillsGrid(skills: skills),
          ],
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final DeveloperProfile profile;

  const _ExperienceCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RECENT POSITION',
                style: AppTypography.mono(
                  fontSize: 11,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.flutterCyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.flutterCyan.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  profile.tenure,
                  style: AppTypography.monoBold(
                    fontSize: 11,
                    color: AppColors.flutterCyan,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            profile.company,
            style: AppTypography.displayBold(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            profile.roleAtCompany,
            style: AppTypography.mono(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),

          // Highlights bullet points
          ...profile.companyHighlights.map((point) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 12),
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.flutterCyan,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: AppTypography.sans(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),

          // Financial & preference pills
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              BadgeChip(
                label: 'Current: ${profile.currentCTC}',
                backgroundColor: const Color(0xFF15151A),
              ),
              BadgeChip(
                label: 'Expected: ${profile.targetCTC}',
                backgroundColor: AppColors.emeraldLive.withOpacity(0.1),
                borderColor: AppColors.emeraldLive.withOpacity(0.3),
                textColor: AppColors.emeraldLive,
              ),
              BadgeChip(
                label: profile.workPreference,
                backgroundColor: const Color(0xFF15151A),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  final List<SkillCategory> skills;

  const _SkillsGrid({required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: skills.map((cat) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: HoverCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cat.indexLabel,
                      style: AppTypography.mono(
                        fontSize: 11,
                        color: AppColors.flutterCyan,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const Icon(
                      Icons.terminal,
                      size: 16,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  cat.title,
                  style: AppTypography.sansBold(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  cat.description,
                  style: AppTypography.sans(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: cat.tags.map((t) => BadgeChip(label: t)).toList(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
