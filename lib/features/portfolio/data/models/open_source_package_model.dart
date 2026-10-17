import '../../domain/entities/open_source_package.dart';

class OpenSourcePackageModel extends OpenSourcePackage {
  const OpenSourcePackageModel({
    required super.title,
    super.subtitle = '',
    required super.badgeLabel,
    required super.description,
    required super.tags,
    super.complianceBadges = const [],
    super.moduleHighlights = const [],
    required super.pubDevUrl,
    required super.repositoryUrl,
    super.license = 'MIT',
    super.isDependencyFree = true,
  });

  factory OpenSourcePackageModel.fromJson(Map<String, dynamic> json) {
    return OpenSourcePackageModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      badgeLabel: json['badgeLabel'] as String,
      description: json['description'] as String,
      tags: List<String>.from(json['tags'] as List? ?? []),
      complianceBadges:
          List<String>.from(json['complianceBadges'] as List? ?? []),
      pubDevUrl: json['pubDevUrl'] as String,
      repositoryUrl: json['repositoryUrl'] as String,
      license: json['license'] as String? ?? 'MIT',
      isDependencyFree: json['isDependencyFree'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'badgeLabel': badgeLabel,
      'description': description,
      'tags': tags,
      'complianceBadges': complianceBadges,
      'pubDevUrl': pubDevUrl,
      'repositoryUrl': repositoryUrl,
      'license': license,
      'isDependencyFree': isDependencyFree,
    };
  }
}

