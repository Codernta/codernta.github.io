import '../../domain/entities/open_source_package.dart';
import '../models/developer_profile_model.dart';
import '../models/open_source_package_model.dart';
import '../models/project_item_model.dart';
import '../models/skill_category_model.dart';

abstract class PortfolioLocalDataSource {
  Future<DeveloperProfileModel> getProfile();
  Future<List<ProjectItemModel>> getProjects();
  Future<List<SkillCategoryModel>> getSkills();
  Future<List<OpenSourcePackageModel>> getOpenSourcePackages();
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  @override
  Future<DeveloperProfileModel> getProfile() async {
    return const DeveloperProfileModel(
      name: 'Nithin TA',
      title: 'Senior Flutter Developer',
      subtitle: 'Senior Flutter & Dart Specialist (4+ Years) / Ex-IIC Web Solutions',
      bio:
          'Full-stack mobile engineer and continuous open-source supporter driven by high frame-rate rendering, clean architecture, and modular state management. Specialized in BLoC, WebSockets, payment rails, and store lifecycle.',
      availabilityStatus: 'IMMEDIATE',
      noticePeriod: '0 Days (Instant)',
      targetCTC: '₹8.0 LPA',
      currentCTC: '₹6.5 LPA',
      workPreference: 'Remote / Hybrid / Onsite',
      company: 'IIC Web Solutions Pvt. Ltd.',
      roleAtCompany: 'Flutter Developer (Remote / Global Distributed Delivery)',
      tenure: '2020 – PRESENT (4+ YEARS)',
      companyHighlights: [
        'Spearheaded architecture of 5+ production mobile applications across HealthTech, ExamTech, and Social E-commerce verticals.',
        'Pioneered bidirectional communication engines utilizing WebSockets & Socket.IO for sub-50ms live chat and vehicle tracking.',
        'Engineered resilient offline-first storage pipelines combining Hive, SQLite, and Firebase synchronization.',
        'Automated builds, code analysis, and streamlined releases directly to Google Play Store and Apple TestFlight.',
      ],
      stats: {
        'years': '4+',
        'yearsLabel': 'Years Exp',
        'apps': '5+',
        'appsLabel': 'Live Apps',
        'pkg': '1',
        'pkgLabel': 'Pub.dev Pkg',
      },
      contactLinks: {
        'email': 'codernta@gmail.com',
        'phone': '+91 80757 76122',
        'github': 'https://github.com',
        'linkedin': 'https://linkedin.com',
        'medium': 'https://medium.com/@codernta',
        'portfolio': 'https://codernta.lovable.app',
        'pubdev': 'https://pub.dev/packages/bharat_fx',
      },
    );
  }

  @override
  Future<List<OpenSourcePackageModel>> getOpenSourcePackages() async {
    return const [
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
  Future<List<SkillCategoryModel>> getSkills() async {
    return const [
      SkillCategoryModel(
        indexLabel: '// 01 STATE & ARCHITECTURE',
        title: 'State Management & Architecture',
        description:
            'BLoC (Business Logic Component), GetX reactive controllers, Provider, Clean Architecture, Dependency Injection (get_it, injectable).',
        tags: ['BLoC', 'GetX', 'SOLID', 'Clean Architecture', 'get_it'],
      ),
      SkillCategoryModel(
        indexLabel: '// 02 REAL-TIME & GEO',
        title: 'WebSockets & Maps',
        description:
            'Live bidirectional messaging via Socket.IO, Google Maps Platform integrations, geofencing, custom marker clusters, background location updates.',
        tags: ['Socket.IO', 'Google Maps', 'Geofencing', 'Live Tracking'],
      ),
      SkillCategoryModel(
        indexLabel: '// 03 CLOUD & COMMERCE',
        title: 'Firebase & Payments',
        description:
            'Firebase Cloud Messaging (FCM Push Notifications), OAuth, Firestore, Razorpay, Stripe SDKs, and in-app purchase handling.',
        tags: ['FCM Push', 'Razorpay', 'Stripe', 'Firestore', 'OAuth'],
      ),
      SkillCategoryModel(
        indexLabel: '// 04 PRODUCTION DELIVERY',
        title: 'App Store Releases',
        description:
            'Full lifecycle Play Console & App Store Connect governance, signing keystores, build variants, profiling memory leaks, and performance optimization.',
        tags: ['Play Store', 'App Store', 'Keystores', 'DevTools', 'CI/CD'],
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
