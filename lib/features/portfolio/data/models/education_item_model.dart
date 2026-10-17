import '../../domain/entities/education_item.dart';

class EducationItemModel extends EducationItem {
  const EducationItemModel({
    required super.degree,
    required super.institution,
    required super.period,
    required super.location,
  });

  factory EducationItemModel.fromJson(Map<String, dynamic> json) {
    return EducationItemModel(
      degree: json['degree'] as String,
      institution: json['institution'] as String,
      period: json['period'] as String,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'institution': institution,
      'period': period,
      'location': location,
    };
  }
}
