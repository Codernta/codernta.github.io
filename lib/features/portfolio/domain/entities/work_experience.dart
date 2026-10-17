/// Domain entity representing a professional employment role.
class WorkExperience {
  final String company;
  final String location;
  final String role;
  final String period;
  final String? employmentType;
  final List<String> highlights;
  final List<String> technologies;
  final bool isCurrent;

  const WorkExperience({
    required this.company,
    required this.location,
    required this.role,
    required this.period,
    this.employmentType,
    required this.highlights,
    required this.technologies,
    this.isCurrent = false,
  });
}
