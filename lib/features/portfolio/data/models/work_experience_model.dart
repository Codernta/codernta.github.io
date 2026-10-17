import '../../domain/entities/work_experience.dart';

class WorkExperienceModel extends WorkExperience {
  const WorkExperienceModel({
    required super.company,
    required super.location,
    required super.role,
    required super.period,
    super.employmentType,
    required super.highlights,
    required super.technologies,
    super.isCurrent,
  });

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) {
    return WorkExperienceModel(
      company: json['company'] as String,
      location: json['location'] as String,
      role: json['role'] as String,
      period: json['period'] as String,
      employmentType: json['employmentType'] as String?,
      highlights: List<String>.from(json['highlights'] as List),
      technologies: List<String>.from(json['technologies'] as List),
      isCurrent: json['isCurrent'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'location': location,
      'role': role,
      'period': period,
      'employmentType': employmentType,
      'highlights': highlights,
      'technologies': technologies,
      'isCurrent': isCurrent,
    };
  }
}
