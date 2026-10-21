import '../../domain/entities/open_source_package.dart';
import '../models/developer_profile_model.dart';
import '../models/education_item_model.dart';
import '../models/open_source_package_model.dart';
import '../models/project_item_model.dart';
import '../models/skill_category_model.dart';
import '../models/work_experience_model.dart';

abstract class PortfolioLocalDataSource {
  Future<DeveloperProfileModel> getProfile();
  Future<List<ProjectItemModel>> getProjects();
  Future<List<SkillCategoryModel>> getSkills();
  Future<List<OpenSourcePackageModel>> getOpenSourcePackages();
  Future<List<WorkExperienceModel>> getExperiences();
  Future<List<EducationItemModel>> getEducation();
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  @override
  Future<DeveloperProfileModel> getProfile() async {
    return const DeveloperProfileModel(
      name: 'Nithin TA',
      title: 'Senior Flutter Developer',
      subtitle: 'Senior Flutter Developer (4+ Years) | Clean Architecture, AI & Cross-Platform Specialist',
      bio:
          'Senior Flutter Developer with 4+ years of experience building scalable Android and iOS applications using Flutter. Experienced in Clean Architecture, BLoC, GetX, Provider, OpenAI integrations, BLE, CI/CD, Firebase, Socket.IO, payment gateways, Google Maps, and performance optimization.',
      availabilityStatus: 'IMMEDIATE',
      noticePeriod: '0 Days (Instant)',
      workPreference: 'Remote / Hybrid / Onsite',
      company: 'IIC WebSolutions Pvt Ltd',
      roleAtCompany: 'Senior Flutter Developer',
      tenure: '06/2025 – PRESENT',
      companyHighlights: [
        'Integrated OpenAI APIs and AI-powered features directly into mobile workflows.',
        'Implemented automated CI/CD pipelines for seamless Android and iOS deployments.',
        'Architected Bluetooth Low Energy (BLE) integrations for hardware communication.',
        'Engineered scalable REST APIs using Clean Architecture, BLoC, GetX, and Provider.',
        'Integrated Firebase ecosystem services and rigorously optimized application performance.',
      ],
      stats: {
        'years': '4+',
        'yearsLabel': 'Years Exp',
        'apps': '7+',
        'appsLabel': 'Live Apps',
        'pkg': '2',
        'pkgLabel': 'Pub.dev Pkgs',
      },
      contactLinks: {
        'email': 'codernta@gmail.com',
        'phone': '+91 8075776122',
        'github': 'https://github.com/codernta',
        'linkedin': 'https://linkedin.com/in/codernta',
        'medium': 'https://medium.com/@codernta',
        'portfolio': 'https://codernta.github.io',
        'pubdev': 'https://pub.dev/packages/haptic_flow',
        'pubdev_haptic_flow': 'https://pub.dev/packages/haptic_flow',
        'pubdev_bharat_fx': 'https://pub.dev/packages/bharat_fx',
        'resume':
            'https://drive.google.com/file/d/1wMiyYuUR3z7vXSxuu8vPeeqrUaXyOCao/view?usp=sharing',
      },
    );
  }

  @override
  Future<List<WorkExperienceModel>> getExperiences() async {
    return const [
      WorkExperienceModel(
        company: 'IIC WebSolutions Pvt Ltd',
        location: 'Trivandrum, Kerala',
        role: 'Senior Flutter Developer',
        period: '06/2025 – Present',
        employmentType: 'Full-time',
        isCurrent: true,
        highlights: [
          'Integrated OpenAI APIs and AI-powered features into production workflows.',
          'Implemented CI/CD pipelines for automated Android and iOS builds and deployments.',
          'Developed Bluetooth Low Energy (BLE) integrations for seamless device communication.',
          'Built scalable REST APIs adhering strictly to Clean Architecture, BLoC, GetX, and Provider.',
          'Integrated Firebase services and optimized app runtime performance and frame stability.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'OpenAI APIs',
          'BLE',
          'CI/CD',
          'BLoC',
          'GetX',
          'Provider',
          'Clean Architecture',
          'Firebase',
        ],
      ),
      WorkExperienceModel(
        company: 'Innobayt Innovative Solutions LLC',
        location: 'Remote, Dubai',
        role: 'SDE-2 Flutter',
        period: '11/2024 – 06/2025',
        employmentType: 'Contract',
        isCurrent: false,
        highlights: [
          'Delivered 3 production-grade Flutter applications from concept to store release.',
          'Implemented Socket.IO based low-latency real-time chat and push notification systems.',
          'Built OpenAI-powered intelligent automation modules for business operations.',
          'Followed Clean Architecture ensuring maintainable, modular, and testable codebases.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'Socket.IO',
          'OpenAI APIs',
          'Clean Architecture',
          'Push Notifications',
          'REST APIs',
        ],
      ),
      WorkExperienceModel(
        company: 'UL Technologies Pvt Ltd',
        location: 'Kerala, India',
        role: 'Software Engineer – Flutter',
        period: '03/2024 – 11/2024',
        employmentType: 'Full-time',
        isCurrent: false,
        highlights: [
          'Architected and built scalable, reusable cross-platform application modules.',
          'Integrated Firebase services, Google Maps Platform, media streaming, and payment gateways.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'Google Maps',
          'Firebase',
          'Media Streaming',
          'Payment Gateways',
          'Clean Code',
        ],
      ),
      WorkExperienceModel(
        company: 'Limenzy Technologies Pvt Ltd',
        location: 'Kerala, India',
        role: 'Flutter Developer',
        period: '06/2022 – 03/2024',
        employmentType: 'Full-time',
        isCurrent: false,
        highlights: [
          'Developed robust cross-platform mobile applications for Android and iOS.',
          'Implemented Google Maps location tracking and secure payment gateway SDKs.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'Google Maps',
          'Payment SDKs',
          'MVVM',
          'REST APIs',
          'Git',
        ],
      ),
    ];
  }

  @override
  Future<List<EducationItemModel>> getEducation() async {
    return const [
      EducationItemModel(
        degree: 'BE – Computer Science & Engineering',
        institution: 'Sasurie Academy of Engineering, Anna University',
        period: '2010 – 2014',
        location: 'Tamil Nadu, India',
      ),
      EducationItemModel(
        degree: 'Higher Secondary – Computer Science',
        institution: 'GVHSS Chorode, Vatakara',
        period: '2008 – 2010',
        location: 'Kerala, India',
      ),
    ];
  }

  @override
  Future<List<SkillCategoryModel>> getSkills() async {
    return const [
      SkillCategoryModel(
        indexLabel: '// 01 STATE & ARCHITECTURE',
        title: 'State Management & Architecture',
        description:
            'Clean Architecture, BLoC (Business Logic Component), GetX reactive controllers, Provider, MVVM, MVC, Dependency Injection (get_it, injectable).',
        tags: ['Clean Architecture', 'BLoC', 'GetX', 'Provider', 'MVVM', 'SOLID'],
      ),
      SkillCategoryModel(
        indexLabel: '// 02 AI, BLE & HARDWARE',
        title: 'OpenAI APIs, BLE & IoT',
        description:
            'Integrating OpenAI APIs for intelligent automation, Bluetooth Low Energy (BLE) device communication protocols, and hardware peripherals.',
        tags: ['OpenAI APIs', 'BLE', 'AI Automation', 'Sensors', 'Protocols'],
      ),
      SkillCategoryModel(
        indexLabel: '// 03 REAL-TIME & GEO',
        title: 'Socket.IO, Google Maps & Media',
        description:
            'Live bidirectional messaging via Socket.IO, Google Maps Platform integrations, geofencing, custom marker clusters, background location updates, audio/video streaming.',
        tags: ['Socket.IO', 'Google Maps', 'Live Tracking', 'Media Streaming'],
      ),
      SkillCategoryModel(
        indexLabel: '// 04 CLOUD, COMMERCE & CI/CD',
        title: 'CI/CD, Firebase & Payments',
        description:
            'Automated CI/CD pipelines for Android & iOS deployments, Firebase Cloud Messaging (FCM), Auth, Firestore, Payment Gateways (Razorpay, Stripe), and Git lifecycle.',
        tags: ['CI/CD Pipelines', 'Firebase', 'Payment Gateways', 'Git', 'App Store / Play Store'],
      ),
    ];
  }

  @override
  Future<List<OpenSourcePackageModel>> getOpenSourcePackages() async {
    return const [
      OpenSourcePackageModel(
        title: 'haptic_flow 📳',
        subtitle:
            'A Declarative Haptic Choreography Engine for Flutter & Mobile Apps',
        badgeLabel: 'PUB.DEV PACKAGE AUTHOR // TACTILE CHOREOGRAPHY & REALISM',
        description:
            'haptic_flow is a production-grade, declarative haptic choreography engine for Flutter that brings true tactile realism to mobile applications. Standard Flutter haptics are limited to isolated clicks; haptic_flow introduces rhythmic timeline scheduling with cancellation tokens, real-world physical presets (Mechanical Safe Dials, Heartbeats, Typewriters, Success Snaps), tactile widgets (HapticSlider, HapticPickerWheel), dynamic HapticScrollPhysics, decoupled mock drivers for 100% test coverage, and zero third-party runtime dependencies.',
        tags: [
          'Flutter & Pure Dart',
          'v0.1.1 on pub.dev',
          '100% Zero-Dependency',
          'Tactile Realism & Physics',
          'Rhythmic Timelines',
          'CancellationToken Safe',
          'Physical Presets',
          'HapticSlider & Picker',
          'HapticScrollPhysics',
          '100% Mock Testing',
          'MIT License',
        ],
        complianceBadges: [
          'Zero Runtime Dependencies',
          'Platform Safe No-Op',
          'CancellationToken Safe',
          '100% Mock Testable',
          'HapticFeedbackBoundary Muting',
          'Pure Dart Engine',
        ],
        license: 'MIT',
        isDependencyFree: true,
        pubDevUrl: 'https://pub.dev/packages/haptic_flow',
        repositoryUrl: 'https://github.com/Codernta/haptic_flow',
        moduleHighlights: [
          PackageModuleHighlight(
            title: 'Rhythmic Timeline Scheduling & Cancellation',
            icon: '⏱️',
            moduleClass: 'HapticTimeline & CancellationToken',
            summary:
                'Frame-accurate multi-stage rhythmic choreographies with cooperative cancellation tokens to eliminate orphaned haptic pulses on unmount.',
            bulletPoints: [
              'Rhythmic Choreography: Compose complex tactile sequences with precise millisecond step durations and rest intervals.',
              'CancellationToken: Safely abort running patterns when users quickly dismiss modals, switch tabs, or cancel gestures.',
              'Dynamic Speed & Scaling: Modifiers to speed up (.scaleSpeed(1.2)) or damp intensity based on device or user settings.',
            ],
            codeSnippet:
                'final token = CancellationToken();\n\n// Start rhythmic sequence with instant cancellation support\nfinal sequence = HapticSequence.builder(\'Custom Pattern\')\n    .light(duration: const Duration(milliseconds: 40))\n    .pause(const Duration(milliseconds: 60))\n    .heavy(duration: const Duration(milliseconds: 100))\n    .scaleSpeed(1.2)\n    .build();\n\nawait HapticFlow.play(sequence, token: token);\n// On screen pop or gesture cancel: token.cancel();',
          ),
          PackageModuleHighlight(
            title: 'Real-World Physical Tactile Presets',
            icon: '🎛️',
            moduleClass: 'HapticPresets',
            summary:
                'Curated sensory presets mimicking mechanical dials, biological heartbeats, vintage typewriters, and affirmative snaps.',
            bulletPoints: [
              'mechanicalDial: Crisp rotary tumblers with fine settling detents for wheels and numeric steppers.',
              'heartbeat: Two-stage biological cardiac rhythm (lub-dub) with diastolic resting pause.',
              'typewriter: Sharp metal typebar impact followed immediately by mechanical carriage escapement.',
              'successSnap & errorAlarm: Two-stage confirmatory snap for transactions and distinct alarm vibrations for errors.',
              'diceRoll: Exponentially decelerating tumbling dice impacts.',
            ],
            codeSnippet:
                '// Bring your app to life with curated physical presets\nawait HapticFlow.play(HapticPresets.mechanicalDial);\nawait HapticFlow.play(HapticPresets.heartbeat);\nawait HapticFlow.play(HapticPresets.successSnap);\nawait HapticFlow.play(HapticPresets.typewriter);\nawait HapticFlow.play(HapticPresets.diceRoll);',
          ),
          PackageModuleHighlight(
            title: 'Tactile Interactive UI Widgets',
            icon: '🎚️',
            moduleClass: 'HapticSlider & HapticPickerWheel',
            summary:
                'Drop-in tactile widgets with customizable detents, center snaps, rotary tumblers, and edge collision bumps.',
            bulletPoints: [
              'HapticSlider: Tactile detent intervals (e.g. every 10 units), distinct center snap bump, and boundary edge bumps.',
              'HapticPickerWheel: Simulates physical rotary tumbler clicks as items rotate past the selection lens.',
              'HapticGestureDetector: Maps taps, double taps, and long presses to calibrated sensory pulses.',
            ],
            codeSnippet:
                'HapticSlider(\n  value: _volume,\n  min: 0.0,\n  max: 100.0,\n  detentInterval: 10.0,      // Subtle tick every 10 units\n  centerDetentValue: 50.0,   // Distinct snap at center\n  onChanged: (val) => setState(() => _volume = val),\n);',
          ),
          PackageModuleHighlight(
            title: 'Dynamic HapticScrollPhysics',
            icon: '📜',
            moduleClass: 'HapticScrollPhysics',
            summary:
                'Drop-in scroll physics providing physical collision bumps on boundary edges, overscroll springs, and distance detents.',
            bulletPoints: [
              'Boundary Collisions: Distinct haptic snap when colliding with top/bottom scroll edges or overscrolling.',
              'Distance Detents: Fires rhythmic tactile feedback per configured distance traveled (e.g. every 80px scrolled).',
              'Composable: Seamlessly wraps BouncingScrollPhysics, ClampingScrollPhysics, or CustomScrollView physics.',
            ],
            codeSnippet:
                'ListView.builder(\n  physics: const HapticScrollPhysics(\n    detentDistance: 80.0,    // Tactile tick every 80px scrolled\n    triggerAtEdges: true,    // Distinct feedback when hitting edges\n    parent: BouncingScrollPhysics(),\n  ),\n  itemCount: 100,\n  itemBuilder: (context, index) => ListTile(title: Text(\'Item \$index\')),\n);',
          ),
          PackageModuleHighlight(
            title: 'Shorthand Tactile Notation & Arithmetic Composition',
            icon: '🎼',
            moduleClass: 'HapticSequence.fromPattern & Operators',
            summary:
                'Expressive tactile notation strings (.-=*_M_H) and arithmetic sequence algebra (+ and *) for rapid sensory prototyping.',
            bulletPoints: [
              'Compact Notation: Compose sequences using characters: . (light), - (medium), = (heavy), * (selection click), ~ (vibrate), _ (pause).',
              'Arithmetic Concatenation (+): Chain multiple sub-sequences seamlessly (intro + finale).',
              'Multiplication (*): Repeat tactile motifs without loops (score * 3).',
            ],
            codeSnippet:
                '// Notation: . or L = light, - or M = medium, = or H = heavy, _ = pause\nfinal score = HapticSequence.fromPattern(\n  \'.-=*_M_H\',\n  tickDuration: const Duration(milliseconds: 50),\n  pauseDuration: const Duration(milliseconds: 80),\n);\n// Arithmetic composition\nfinal song = (score * 2) + HapticPresets.successSnap;\nawait HapticFlow.play(song);',
          ),
          PackageModuleHighlight(
            title: 'Clean Architecture & 100% Mock Testing',
            icon: '🧪',
            moduleClass: 'HapticDriver & MockHapticDriver',
            summary:
                'Decoupled driver architecture enabling deterministic unit and widget testing without native platform channel errors.',
            bulletPoints: [
              'Decoupled HapticDriver: Isolates Flutter platform channels behind an extensible interface.',
              'Bundled MockHapticDriver: Records calls and enables 100% unit and widget test coverage.',
              'Zero Platform Crashes: Gracefully falls back to safe no-ops on web and unsupported desktop environments.',
              'Zero Dependencies: Pure Dart and Flutter with strict security sanitization and zero third-party dependencies.',
            ],
            codeSnippet:
                'test(\'verifies custom choreography triggers in order\', () async {\n  final mockDriver = MockHapticDriver();\n  final controller = HapticFlowController(driver: mockDriver);\n  await controller.play(HapticPresets.successSnap);\n  expect(mockDriver.invocations.length, 2);\n  expect(mockDriver.invocations.first.type, HapticPulseType.light);\n});',
          ),
          PackageModuleHighlight(
            title: 'Accessibility & Scoped Boundaries',
            icon: '♿',
            moduleClass: 'HapticFeedbackBoundary',
            summary:
                'Respects user sensory preferences with granular scoped muting, scaling, and system-wide master toggle control.',
            bulletPoints: [
              'Scoped Boundaries: Mute or attenuate haptics for specific subtrees (e.g. background feeds or low battery modes).',
              'Global Master Switch: Instantly enable or disable haptics app-wide via HapticFlow.enabled.',
              'Respects OS Accessibility: Automatically integrates with OS-level haptic preferences.',
            ],
            codeSnippet:
                '// Mute haptics within a specific widget subtree\nHapticFeedbackBoundary(\n  enabled: false,\n  child: NonInteractiveWidget(),\n);\n\n// Or globally toggle haptics\nHapticFlow.enabled = false;',
          ),
        ],
      ),
      OpenSourcePackageModel(
        title: 'Bharat FX 🇮🇳',
        subtitle:
            'The Ultimate Indian Localization, Fintech & Input Toolkit for Flutter',
        badgeLabel: 'PUB.DEV PACKAGE AUTHOR // CONTINUOUS OPEN-SOURCE SUPPORTER',
        description:
            'bharat_fx is an enterprise-grade, 100% dependency-free Flutter & Dart toolkit designed specifically for Indian localization, fintech, and banking applications. It incorporates strict compliance guidelines from the Reserve Bank of India (RBI), National Payments Corporation of India (NPCI), Unique Identification Authority of India (UIDAI), PCI DSS 4.0, and the Digital Personal Data Protection (DPDP) Act 2023.',
        tags: [
          'Flutter & Pure Dart',
          '100% Zero-Dependency',
          'Continuous Open-Source Supporter',
          'Fintech & Banking Rails',
          'RBI & NPCI Compliant',
          'PCI DSS 4.0 & DPDP Act',
          'UIDAI Verhoeff Checksum',
          'Exact Integer Paise Money',
          'MIT License',
        ],
        complianceBadges: [
          'RBI Guidelines',
          'NPCI Standards',
          'UIDAI Verhoeff',
          'PCI DSS 4.0',
          'DPDP Act 2023',
          'Pure Dart RFC 6234',
        ],
        license: 'MIT',
        isDependencyFree: true,
        pubDevUrl: 'https://pub.dev/packages/bharat_fx',
        repositoryUrl: 'https://github.com/nithinta/bharat_fx',
        moduleHighlights: [
          PackageModuleHighlight(
            title: 'Enterprise Fintech Security',
            icon: '🛡️',
            moduleClass: 'BharatSecurity',
            summary:
                'Timing side-channel defenses, memory isolation, auto PII masking, pure-Dart cryptographic hashing, and anti-tamper guards.',
            bulletPoints: [
              'Timing Side-Channel Defense (TimingSafe): Constant-time equality checks for OTPs, MPINs, transaction signatures, and auth tokens.',
              'Sensitive Memory Protection (SensitiveValue<T>): Zeroizable, leak-proof memory wrapper that suppresses raw values from logs, crash reports, and JSON telemetry.',
              'Comprehensive PII Redactor (BharatPiiRedactor): Auto-detects and redacts Aadhaar (UIDAI rules), VIDs, PANs, Luhn-verified cards, CVVs, bank accounts, UPI VPAs, and phones in text and JSON maps.',
              'Zero-Dependency Cryptographic Integrity (BharatHash): Pure-Dart RFC 6234 SHA-256 and RFC 2104 HMAC-SHA256 payload signing and payment checksum verification.',
              'Anti-Keylogging & Anti-Clipboard Guards: Disables third-party cloud keyboard harvesting and clipboard snooping on sensitive financial inputs.',
              'Anti-Brute Force Guard (AntiBruteForceGuard): Sliding-window rate limiter to throttle credential and OTP guessing attacks.',
            ],
            codeSnippet:
                '// Constant-time OTP check & leak-proof memory\nfinal isMpinValid = TimingSafe.verify(enteredMpin, serverHash);\nfinal token = SensitiveValue<String>(\'secure_auth_session\');\n// Redacts Aadhaar, PAN, UPI VPAs from JSON logs\nfinal sanitizedJson = BharatPiiRedactor.redactMap(requestPayload);',
          ),
          PackageModuleHighlight(
            title: 'Exact Precision Money & Indian Currency',
            icon: '💰',
            moduleClass: 'BharatMoney & BharatCurrency',
            summary:
                'Eliminates IEEE 754 floating-point rounding bugs using integer Paise (1 Rupee = 100 Paise) with NPCI limit enforcement.',
            bulletPoints: [
              'Eliminates IEEE 754 floating-point rounding bugs using integer Paise (1 Rupee = 100 Paise).',
              'Pre-built NPCI & RBI transaction limit checks (UPI ₹1L standard, ₹2L capital markets, ₹5L tax/institutions; IMPS ₹5L).',
              'Indian numbering system (Lakh / Crore: ₹1,50,000), compact scales (1.5 L, 2.5 Cr), and number-to-words in 8 Indian languages.',
            ],
            codeSnippet:
                '// Exact integer arithmetic: no float rounding bugs\nfinal amount = BharatMoney.fromPaise(15000000); // ₹1,50,000.00\nprint(amount.formatIndian()); // ₹1,50,000.00\nprint(amount.toWords(Language.hindi)); // एक लाख पचास हज़ार रुपये\nfinal isValid = BharatUpi.verifyLimit(amount, UpiLimitType.standard);',
          ),
          PackageModuleHighlight(
            title: 'Payment Cards & RBI Tokenization',
            icon: '💳',
            moduleClass: 'BharatCard & BharatCardToken',
            summary:
                'Multi-network card validation, Modulo 10 Luhn checksums, PCI DSS 4.0 compliant masking, and RBI Card-on-File Tokenization (CoFT).',
            bulletPoints: [
              'RuPay (NPCI), Visa, Mastercard, and Amex detection with Luhn (Modulo 10) checksum verification.',
              'PCI DSS 4.0 compliant masking and RBI Card-on-File Tokenization (CoFT) models.',
            ],
            codeSnippet:
                'final card = BharatCard.parse(\'6071521234567890\');\nif (card.isValidLuhn && card.network == CardNetwork.ruPay) {\n  final masked = card.toPciDssMask(); // 6071 •••• •••• 7890\n  final token = BharatCardToken.createCoFT(card: card, merchantId: \'MID123\');\n}',
          ),
          PackageModuleHighlight(
            title: 'NPCI UPI Intent & Fraud Defenses',
            icon: '📱',
            moduleClass: 'BharatUpiIntent & BharatUpi',
            summary:
                'Deep link upi://pay tampering verification, transaction amount ceilings, and zero-width / homoglyph anti-phishing defense.',
            bulletPoints: [
              'Parses and verifies upi://pay deep links against parameter tampering, amount limits, and non-INR currency injection.',
              'Defends against invisible zero-width spaces, Cyrillic/Greek homoglyphs, and phishing handle patterns.',
            ],
            codeSnippet:
                'final upi = BharatUpiIntent.parse(\'upi://pay?pa=merchant@upi&pn=Store&am=500000\');\n// Defend against invisible characters & homoglyph phishing\nfinal isSafeHandle = BharatUpi.detectHomoglyphPhishing(upi.payeeVpa);\nfinal isCompliant = upi.verifyPayloadIntegrity();',
          ),
          PackageModuleHighlight(
            title: 'Indian Bank Accounts & Merged IFSC',
            icon: '🏦',
            moduleClass: 'BharatBankAccount & BharatIfsc',
            summary:
                'Bank-specific 9-to-18 digit validation (SBI, HDFC, ICICI, etc.) with defunct merged bank IFSC migration advisories.',
            bulletPoints: [
              '9-to-18 digit account validation with bank-specific lengths (SBI, HDFC, ICICI, Axis, PNB, etc.) and timing-safe confirmation matching.',
              'Detects defunct merged bank IFSC codes (Allahabad, Syndicate, Oriental, etc.) with migration advisories.',
            ],
            codeSnippet:
                '// Bank-specific format & confirmation check\nfinal accValid = BharatBankAccount.validate(\'0000001234567890\', bank: Bank.sbi);\n// Detects merged IFSC (e.g. Allahabad Bank -> Indian Bank)\nfinal ifscInfo = BharatIfsc.resolve(\'ALLA0210001\');\nprint(ifscInfo.isDefunct); // true: Migrated to IDIB000A150',
          ),
          PackageModuleHighlight(
            title: 'Comprehensive Government, Identity & Corporate IDs',
            icon: '🆔',
            moduleClass: 'BharatId',
            summary:
                'UIDAI Aadhaar Verhoeff checksum, MoRTH Driving License RTO resolution, Voter ID, MEA Passport, and MCA CIN/TAN/DIN.',
            bulletPoints: [
              'UIDAI Aadhaar & Virtual ID (VID): 12-digit Aadhaar & 16-digit VID with official Verhoeff checksum and privacy masking.',
              'MoRTH Driving License (BharatDrivingLicense): 15/16-char format parsing, state and RTO office lookup, issue year extraction, and auto-hyphenation.',
              'Voter ID (EPIC) & Passport (BharatVoterId & BharatPassport): Standard 10-char ECI Voter IDs and 8-char MEA Passports with privacy masking.',
              'Corporate & MCA Registrations (BharatCin, BharatTan, BharatDin): 21-char CIN with listing status, NIC industry, and corporate entity type; 10-char TAN; and 8-digit DIN.',
            ],
            codeSnippet:
                '// UIDAI Verhoeff algorithm verification\nfinal isAadhaarValid = BharatAadhaar.verifyVerhoeff(\'453289123456\');\nfinal maskedAadhaar = BharatAadhaar.mask(\'453289123456\'); // ••••••••3456\n// MoRTH Driving License parser\nfinal dl = BharatDrivingLicense.parse(\'DL-1420110012345\');',
          ),
          PackageModuleHighlight(
            title: 'Indian GST & Tax Calculation Engine',
            icon: '🧾',
            moduleClass: 'BharatGst',
            summary:
                'Precision integer Paise arithmetic: automatic Intra-State (CGST + SGST) vs Inter-State (IGST) and reverse inclusive MRP calculation.',
            bulletPoints: [
              'Precision integer Paise arithmetic: automatic Intra-State (CGST + SGST equal split) vs Inter-State (IGST).',
              'Reverse / Inclusive GST calculation extracting taxable base amount and tax components from MRP.',
            ],
            codeSnippet:
                'final gst = BharatGst.calculate(amountInPaise: 1000000, gstRate: 18.0, isInterstate: false);\nprint(gst.cgstPaise); // 90000 paise (₹900.00)\nprint(gst.sgstPaise); // 90000 paise (₹900.00)\n// Reverse GST calculation from MRP\nfinal reverse = BharatGst.extractFromInclusiveMrp(mrpPaise: 118000, gstRate: 18.0);',
          ),
          PackageModuleHighlight(
            title: 'Indian Fiscal & Market Settlement Calendar',
            icon: '📅',
            moduleClass: 'BharatFiscal',
            summary:
                'April-March Financial & Assessment Year resolution, Advance Tax quarterly schedules, RBI Bank Holidays, and T+1/T+2 market settlement.',
            bulletPoints: [
              'Indian Financial Year (FY 2024-25) and Assessment Year (AY 2025-26) resolution (April-March cycle).',
              'Advance Tax installment due date schedules (June 15, Sep 15, Dec 15, Mar 15).',
              'RBI Bank Holiday calendar with T+1 and T+2 market settlement date calculation.',
            ],
            codeSnippet:
                'final fy = BharatFiscal.getFinancialYear(DateTime.now()); // FY 2024-25\nfinal nextTaxDue = BharatFiscal.getNextAdvanceTaxDeadline(); // 15-Dec\nfinal settlementDate = BharatFiscal.calculateSettlement(tradeDate, cycle: SettlementCycle.tPlus1);',
          ),
        ],
      ),
    ];
  }

  @override
  Future<List<ProjectItemModel>> getProjects() async {
    return const [
      ProjectItemModel(
        indexLabel: '01 // COMMERCE & SOCIAL',
        title: 'Petbae',
        subtitle: 'Full-Featured Pet Ecosystem & Tracking',
        description:
            'Full-featured pet ecosystem mobile platform. Implemented low-latency bidirectional real-time chat powered by Socket.IO, precise live tracking via Google Maps, and multi-gateway secure checkout.',
        tags: ['Socket.IO', 'Google Maps', 'Payment Gateway', 'Live Tracking'],
        playStoreUrl: 'https://play.google.com',
        isLive: true,
        verificationBadge: 'Play Store Verified',
      ),
      ProjectItemModel(
        indexLabel: '02 // ARCHITECTURE BENCHMARK',
        title: 'Demeter',
        subtitle: 'Clean Architecture Enterprise Mobile Client',
        description:
            'Modern enterprise cross-platform mobile client built strictly around Clean Architecture and BLoC pattern. Integrates Firebase Social Auth and rigorous state separation for high reliability.',
        tags: ['Clean Architecture', 'BLoC State', 'Firebase Auth', 'SOLID'],
        playStoreUrl: 'https://play.google.com',
        isLive: true,
        verificationBadge: 'Play Store Verified',
      ),
      ProjectItemModel(
        indexLabel: '03 // MEDIA & STREAMING',
        title: 'Mash',
        subtitle: 'Low-Latency Media Streaming Engine',
        description:
            'Dynamic media streaming app featuring audio and video pipelines, low-latency playback buffering, in-app purchase monetization, and custom audio visualizer rendering.',
        tags: ['Audio/Video Streaming', 'In-App Payments', 'Custom UI', 'Visualizer'],
        playStoreUrl: 'https://play.google.com',
        isLive: true,
        verificationBadge: 'Play Store Verified',
      ),
      ProjectItemModel(
        indexLabel: '04 // SMART MARKETPLACE',
        title: 'Dalilin (Go DAW)',
        subtitle: 'Smart Multi-Vendor Marketplace & Delivery Ecosystem',
        description:
            'All-in-one smart marketplace and digital commerce platform hosting 10,000+ multi-category stores across retail, food & beverage, and services. Features merchant storefronts, real-time order tracking, AI business tools, and integrated delivery logistics.',
        tags: ['Multi-Vendor', 'Live Tracking', 'AI Merchant Hub', 'Commerce Rails'],
        playStoreUrl: 'https://play.google.com/store/apps/details?id=net.dalil.app',
        isLive: true,
        verificationBadge: 'Play Store Verified',
      ),
      ProjectItemModel(
        indexLabel: '05 // EDUTECH & TEST ENGINE',
        title: 'Eduwizz Prometric',
        subtitle: 'High-Concurrency Assessment Platform',
        description:
            'Complex examination test engine handling timed evaluations, question randomization, auto-save state recovery during connectivity drops, and rich graphical score analytics dashboards.',
        tags: ['Assessment Engine', 'Offline Persistence', 'Analytics Visualizer', 'BLoC'],
        playStoreUrl: 'https://play.google.com',
        isLive: true,
        verificationBadge: 'Play Store Verified',
      ),
    ];
  }
}
