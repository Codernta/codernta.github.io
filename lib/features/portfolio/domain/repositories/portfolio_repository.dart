import '../entities/developer_profile.dart';
import '../entities/open_source_package.dart';
import '../entities/project_item.dart';
import '../entities/skill_category.dart';

/// Abstract contract for fetching portfolio domain entities.
abstract class PortfolioRepository {
  Future<DeveloperProfile> getProfile();
  Future<List<ProjectItem>> getProjects();
  Future<List<SkillCategory>> getSkills();
  Future<List<OpenSourcePackage>> getOpenSourcePackages();
}
