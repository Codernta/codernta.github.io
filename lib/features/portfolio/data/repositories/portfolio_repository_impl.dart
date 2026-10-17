import '../../domain/entities/developer_profile.dart';
import '../../domain/entities/education_item.dart';
import '../../domain/entities/open_source_package.dart';
import '../../domain/entities/project_item.dart';
import '../../domain/entities/skill_category.dart';
import '../../domain/entities/work_experience.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  PortfolioRepositoryImpl({required this.localDataSource});

  @override
  Future<DeveloperProfile> getProfile() async {
    return await localDataSource.getProfile();
  }

  @override
  Future<List<OpenSourcePackage>> getOpenSourcePackages() async {
    return await localDataSource.getOpenSourcePackages();
  }

  @override
  Future<List<ProjectItem>> getProjects() async {
    return await localDataSource.getProjects();
  }

  @override
  Future<List<SkillCategory>> getSkills() async {
    return await localDataSource.getSkills();
  }

  @override
  Future<List<WorkExperience>> getExperiences() async {
    return await localDataSource.getExperiences();
  }

  @override
  Future<List<EducationItem>> getEducation() async {
    return await localDataSource.getEducation();
  }
}
