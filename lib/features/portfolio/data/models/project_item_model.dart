import '../../domain/entities/project_item.dart';

class ProjectItemModel extends ProjectItem {
  const ProjectItemModel({
    required super.indexLabel,
    required super.title,
    required super.subtitle,
    required super.description,
    required super.tags,
    required super.playStoreUrl,
    super.isLive = true,
    super.verificationBadge = 'Play Store Verified',
  });

  factory ProjectItemModel.fromJson(Map<String, dynamic> json) {
    return ProjectItemModel(
      indexLabel: json['indexLabel'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      tags: List<String>.from(json['tags'] as List),
      playStoreUrl: json['playStoreUrl'] as String,
      isLive: json['isLive'] as bool? ?? true,
      verificationBadge:
          json['verificationBadge'] as String? ?? 'Play Store Verified',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'indexLabel': indexLabel,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'tags': tags,
      'playStoreUrl': playStoreUrl,
      'isLive': isLive,
      'verificationBadge': verificationBadge,
    };
  }
}
