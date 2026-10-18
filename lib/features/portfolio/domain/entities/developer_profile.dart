/// Domain entity representing the developer's professional profile.
class DeveloperProfile {
  final String name;
  final String title;
  final String subtitle;
  final String bio;
  final String availabilityStatus;
  final String noticePeriod;
  final String workPreference;
  final String company;
  final String roleAtCompany;
  final String tenure;
  final List<String> companyHighlights;
  final Map<String, String> stats;
  final Map<String, String> contactLinks;

  const DeveloperProfile({
    required this.name,
    required this.title,
    required this.subtitle,
    required this.bio,
    required this.availabilityStatus,
    required this.noticePeriod,
    required this.workPreference,
    required this.company,
    required this.roleAtCompany,
    required this.tenure,
    required this.companyHighlights,
    required this.stats,
    required this.contactLinks,
  });
}
