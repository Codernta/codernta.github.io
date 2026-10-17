import '../../domain/entities/skill_category.dart';

class SkillCategoryModel extends SkillCategory {
  const SkillCategoryModel({
    required super.indexLabel,
    required super.title,
    required super.description,
    required super.tags,
  });

  factory SkillCategoryModel.fromJson(Map<String, dynamic> json) {
    return SkillCategoryModel(
      indexLabel: json['indexLabel'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      tags: List<String>.from(json['tags'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'indexLabel': indexLabel,
      'title': title,
      'description': description,
      'tags': tags,
    };
  }
}
