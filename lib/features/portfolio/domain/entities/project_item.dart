/// Domain entity representing a production application / project.
class ProjectItem {
  final String indexLabel;
  final String title;
  final String subtitle;
  final String description;
  final List<String> tags;
  final String playStoreUrl;
  final bool isLive;
  final String verificationBadge;

  const ProjectItem({
    required this.indexLabel,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.tags,
    required this.playStoreUrl,
    this.isLive = true,
    this.verificationBadge = 'Play Store Verified',
  });
}
