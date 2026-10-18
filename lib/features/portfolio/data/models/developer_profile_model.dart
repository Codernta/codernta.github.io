import '../../domain/entities/developer_profile.dart';

class DeveloperProfileModel extends DeveloperProfile {
  const DeveloperProfileModel({
    required super.name,
    required super.title,
    required super.subtitle,
    required super.bio,
    required super.availabilityStatus,
    required super.noticePeriod,
    required super.workPreference,
    required super.company,
    required super.roleAtCompany,
    required super.tenure,
    required super.companyHighlights,
    required super.stats,
    required super.contactLinks,
  });

  factory DeveloperProfileModel.fromJson(Map<String, dynamic> json) {
    return DeveloperProfileModel(
      name: json['name'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      bio: json['bio'] as String,
      availabilityStatus: json['availabilityStatus'] as String,
      noticePeriod: json['noticePeriod'] as String,
      workPreference: json['workPreference'] as String,
      company: json['company'] as String,
      roleAtCompany: json['roleAtCompany'] as String,
      tenure: json['tenure'] as String,
      companyHighlights: List<String>.from(json['companyHighlights'] as List),
      stats: Map<String, String>.from(json['stats'] as Map),
      contactLinks: Map<String, String>.from(json['contactLinks'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'subtitle': subtitle,
      'bio': bio,
      'availabilityStatus': availabilityStatus,
      'noticePeriod': noticePeriod,
      'workPreference': workPreference,
      'company': company,
      'roleAtCompany': roleAtCompany,
      'tenure': tenure,
      'companyHighlights': companyHighlights,
      'stats': stats,
      'contactLinks': contactLinks,
    };
  }
}
