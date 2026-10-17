/// Domain entity representing a skill & capability domain.
class SkillCategory {
  final String indexLabel;
  final String title;
  final String description;
  final List<String> tags;

  const SkillCategory({
    required this.indexLabel,
    required this.title,
    required this.description,
    required this.tags,
  });
}
