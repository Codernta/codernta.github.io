import '../entities/developer_profile.dart';
import '../entities/open_source_package.dart';
import '../entities/project_item.dart';
import '../entities/skill_category.dart';
import '../repositories/portfolio_repository.dart';

/// Aggregate model containing complete portfolio data.
class PortfolioData {
  final DeveloperProfile profile;
  final List<ProjectItem> projects;
  final List<SkillCategory> skills;
  final List<OpenSourcePackage> openSourcePackages;

  const PortfolioData({
    required this.profile,
    required this.projects,
    required this.skills,
    required this.openSourcePackages,
  });
}

/// Use case that orchestrates fetching full portfolio data from the repository.
class GetPortfolioData {
  final PortfolioRepository repository;

  GetPortfolioData(this.repository);

  Future<PortfolioData> call() async {
    final profile = await repository.getProfile();
    final projects = await repository.getProjects();
    final skills = await repository.getSkills();
    final packages = await repository.getOpenSourcePackages();

    return PortfolioData(
      profile: profile,
      projects: projects,
      skills: skills,
      openSourcePackages: packages,
    );
  }
}
