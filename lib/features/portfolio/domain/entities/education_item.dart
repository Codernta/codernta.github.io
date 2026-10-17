/// Domain entity representing an educational qualification.
class EducationItem {
  final String degree;
  final String institution;
  final String period;
  final String location;

  const EducationItem({
    required this.degree,
    required this.institution,
    required this.period,
    required this.location,
  });
}
