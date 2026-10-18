import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/hover_card.dart';
import '../../../../core/widgets/pulsing_radar_dot.dart';
import '../../../../core/widgets/scroll_reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/developer_profile.dart';
import '../../domain/entities/education_item.dart';
import '../../domain/entities/skill_category.dart';
import '../../domain/entities/work_experience.dart';
import '../controllers/portfolio_controller.dart';

class TimelineExperienceSection extends StatelessWidget {
  final DeveloperProfile profile;
  final List<WorkExperience> experiences;
  final List<EducationItem> education;
  final List<SkillCategory> skills;
  final PortfolioController controller;

  const TimelineExperienceSection({
    super.key,
    required this.profile,
    required this.experiences,
    required this.education,
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
          ScrollReveal(
            child: const SectionHeader(
              label: '02 / PROFESSIONAL TIMELINE',
              title: 'ENGINEERING ROLES & CAPABILITIES',
              subtitle:
                  '4+ years building high-performance, cross-platform Android and iOS solutions adhering to Clean Architecture, SOLID, and scalable state management.',
            ),
          ),
          const SizedBox(height: 32),

          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Experiences & Education Timeline
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ExperienceList(
                        experiences: experiences,
                        profile: profile,
                      ),
                      const SizedBox(height: 32),
                      _EducationSection(education: education),
                    ],
                  ),
                ),
                const SizedBox(width: 28),
                // Right: 4 Skill Domain Cards Grid
                Expanded(
                  flex: 5,
                  child: _SkillsGrid(skills: skills),
                ),
              ],
            )
          else ...[
            _ExperienceList(
              experiences: experiences,
              profile: profile,
            ),
            const SizedBox(height: 28),
            _EducationSection(education: education),
            const SizedBox(height: 28),
            _SkillsGrid(skills: skills),
          ],
        ],
      ),
    );
  }
}

class _ExperienceList extends StatelessWidget {
  final List<WorkExperience> experiences;
  final DeveloperProfile profile;

  const _ExperienceList({
    required this.experiences,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.work_outline,
              size: 16,
              color: AppColors.neonGreen,
            ),
            const SizedBox(width: 8),
            Text(
              'WORK EXPERIENCE',
              style: AppTypography.monoBold(
                fontSize: 12,
                color: AppColors.neonGreen,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...experiences.asMap().entries.map((entry) {
          final index = entry.key;
          final exp = entry.value;
          final isLast = index == experiences.length - 1;

          return ScrollReveal(
            delay: Duration(milliseconds: index * 90),
            child: _ExperienceTimelineCard(
              experience: exp,
              isLast: isLast,
              profile: exp.isCurrent ? profile : null,
            ),
          );
        }),
      ],
    );
  }
}

class _ExperienceTimelineCard extends StatelessWidget {
  final WorkExperience experience;
  final bool isLast;
  final DeveloperProfile? profile;

  const _ExperienceTimelineCard({
    required this.experience,
    required this.isLast,
    this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator with glowing line
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: experience.isCurrent
                    ? const PulsingRadarDot(size: 10)
                    : Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF18181B),
                          border: Border.all(
                            color: const Color(0xFF3F3F46),
                            width: 2,
                          ),
                        ),
                      ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          experience.isCurrent
                              ? AppColors.neonGreen.withValues(alpha: 0.8)
                              : const Color(0xFF27272A),
                          const Color(0xFF27272A),
                        ],
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // Main Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: HoverCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Role Badge & Period
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              experience.role,
                              style: AppTypography.displayBold(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            if (experience.isCurrent)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.neonGreen.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppColors.neonGreen.withValues(alpha: 0.4),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const PulsingRadarDot(size: 6),
                                    const SizedBox(width: 4),
                                    Text(
                                      'PRESENT',
                                      style: AppTypography.monoBold(
                                        fontSize: 10,
                                        color: AppColors.neonGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (experience.employmentType != null &&
                                !experience.isCurrent)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1B1B22),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Text(
                                  experience.employmentType!.toUpperCase(),
                                  style: AppTypography.mono(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: experience.isCurrent
                                ? AppColors.neonGreen.withValues(alpha: 0.12)
                                : const Color(0xFF14141A),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: experience.isCurrent
                                  ? AppColors.neonGreen.withValues(alpha: 0.35)
                                  : AppColors.border,
                            ),
                          ),
                          child: Text(
                            experience.period,
                            style: AppTypography.monoBold(
                              fontSize: 11,
                              color: experience.isCurrent
                                  ? AppColors.neonGreen
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Company & Location Wrap
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          experience.company,
                          style: AppTypography.sansBold(
                            fontSize: 15,
                            color: AppColors.neonGreen,
                          ),
                        ),
                        Text(
                          '•',
                          style: AppTypography.mono(color: AppColors.textMuted),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: AppColors.textMuted,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              experience.location,
                              style: AppTypography.sans(
                                fontSize: 13,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.borderMuted, height: 1),
                    const SizedBox(height: 14),

                    // Bullet Points Highlights
                    ...experience.highlights.map((highlight) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6, right: 10),
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: experience.isCurrent
                                    ? AppColors.neonGreen
                                    : AppColors.textSecondary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                highlight,
                                style: AppTypography.sans(
                                  fontSize: 13.5,
                                  color: AppColors.textPrimary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 12),

                    // Technologies Tags
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: experience.technologies.map((t) {
                        return BadgeChip(
                          label: t,
                          backgroundColor: const Color(0xFF141418),
                        );
                      }).toList(),
                    ),

                    // Availability pills for current position
                    if (profile != null) ...[
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          BadgeChip(
                            label: 'Notice: ${profile!.noticePeriod}',
                            backgroundColor:
                                AppColors.neonGreen.withValues(alpha: 0.1),
                            borderColor:
                                AppColors.neonGreen.withValues(alpha: 0.3),
                            textColor: AppColors.neonGreen,
                          ),
                          BadgeChip(
                            label: profile!.workPreference,
                            backgroundColor: const Color(0xFF141418),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationSection extends StatelessWidget {
  final List<EducationItem> education;

  const _EducationSection({required this.education});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.school_outlined,
              size: 16,
              color: AppColors.neonGreen,
            ),
            const SizedBox(width: 8),
            Text(
              'EDUCATION',
              style: AppTypography.monoBold(
                fontSize: 12,
                color: AppColors.neonGreen,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...education.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return ScrollReveal(
            delay: Duration(milliseconds: 100 + (index * 90)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: HoverCard(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2, right: 14),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.neonGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.neonGreen.withValues(alpha: 0.25),
                        ),
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 20,
                        color: AppColors.neonGreen,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              Text(
                                item.degree,
                                style: AppTypography.sansBold(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF15151A),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Text(
                                  item.period,
                                  style: AppTypography.mono(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.institution,
                            style: AppTypography.sans(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.location,
                            style: AppTypography.mono(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  final List<SkillCategory> skills;

  const _SkillsGrid({required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.bolt_outlined,
              size: 16,
              color: AppColors.neonGreen,
            ),
            const SizedBox(width: 8),
            Text(
              'TECHNICAL PROFICIENCIES',
              style: AppTypography.monoBold(
                fontSize: 12,
                color: AppColors.neonGreen,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...skills.asMap().entries.map((entry) {
          final index = entry.key;
          final cat = entry.value;

          return ScrollReveal(
            delay: Duration(milliseconds: 150 + (index * 90)),
            child: Padding(
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
                            color: AppColors.neonGreen,
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
                        fontSize: 16,
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
                      children:
                          cat.tags.map((t) => BadgeChip(label: t)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
