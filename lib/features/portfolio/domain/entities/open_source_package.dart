/// Domain model for a specific feature highlight or module within an open-source package.
class PackageModuleHighlight {
  final String title;
  final String icon;
  final String moduleClass;
  final String summary;
  final List<String> bulletPoints;
  final String codeSnippet;

  const PackageModuleHighlight({
    required this.title,
    required this.icon,
    required this.moduleClass,
    required this.summary,
    required this.bulletPoints,
    required this.codeSnippet,
  });
}

/// Domain entity representing open-source contributions.
class OpenSourcePackage {
  final String title;
  final String subtitle;
  final String badgeLabel;
  final String description;
  final List<String> tags;
  final List<String> complianceBadges;
  final List<PackageModuleHighlight> moduleHighlights;
  final String pubDevUrl;
  final String repositoryUrl;
  final String license;
  final bool isDependencyFree;

  const OpenSourcePackage({
    required this.title,
    this.subtitle = '',
    required this.badgeLabel,
    required this.description,
    required this.tags,
    this.complianceBadges = const [],
    this.moduleHighlights = const [],
    required this.pubDevUrl,
    required this.repositoryUrl,
    this.license = 'MIT',
    this.isDependencyFree = true,
  });
}

