import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/hover_card.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/open_source_package.dart';
import '../controllers/portfolio_controller.dart';

class OpenSourceSection extends StatelessWidget {
  final List<OpenSourcePackage> packages;
  final PortfolioController controller;

  const OpenSourceSection({
    super.key,
    required this.packages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (packages.isEmpty) return const SizedBox.shrink();
    final pkg = packages.first;
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: controller.openSourceKey,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: '01 / OPEN-SOURCE FINTECH CONTRIBUTION',
            title: 'PUB.DEV PACKAGE AUTHOR: BHARAT FX 🇮🇳',
            subtitle:
                'Enterprise-grade, 100% dependency-free Flutter & Dart toolkit designed specifically for Indian localization, fintech, and banking applications.',
          ),
          const SizedBox(height: 28),

          // Main Hero Showcase Card
          HoverCard(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: _PackageDetails(pkg: pkg),
                      ),
                      const SizedBox(width: 32),
                      const Expanded(
                        flex: 6,
                        child: _FintechInteractiveSandbox(),
                      ),
                    ],
                  )
                else ...[
                  _PackageDetails(pkg: pkg),
                  const SizedBox(height: 28),
                  const _FintechInteractiveSandbox(),
                ],
              ],
            ),
          ),

          const SizedBox(height: 36),

          // 100% Dependency-Free & Strict Compliance Banner
          _ComplianceTrustBanner(isMobile: isMobile),

          const SizedBox(height: 36),

          // Section Sub-header for Modules Matrix
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.flutterCyan,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '🌟 8 KEY ARCHITECTURAL HIGHLIGHTS & MODULES',
                style: AppTypography.monoBold(
                  fontSize: isMobile ? 12 : 14,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 8 Key Highlights Grid
          _HighlightsGrid(
            highlights: pkg.moduleHighlights,
            isDesktop: isDesktop,
          ),
        ],
      ),
    );
  }
}

class _PackageDetails extends StatelessWidget {
  final OpenSourcePackage pkg;

  const _PackageDetails({required this.pkg});

  void _copyDependency(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: 'bharat_fx: ^1.0.0'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF16161B),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Copied "bharat_fx: ^1.0.0" to clipboard',
          style: AppTypography.mono(color: AppColors.flutterCyan),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status & Pub Points Badges Row
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1910),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: const Color(0x60FBBF24),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🌟 ', style: TextStyle(fontSize: 10)),
                  Text(
                    'CONTINUOUS OPEN-SOURCE SUPPORTER',
                    style: AppTypography.monoBold(
                      fontSize: 10,
                      color: const Color(0xFFFBBF24),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.flutterCyan.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.flutterCyan.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                'PUB.DEV VERIFIED',
                style: AppTypography.monoBold(
                  fontSize: 10,
                  color: AppColors.flutterCyan,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.emeraldLive.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.emeraldLive.withValues(alpha: 0.35),
                ),
              ),
              child: Text(
                '⚡ 100% DEPENDENCY-FREE',
                style: AppTypography.monoBold(
                  fontSize: 10,
                  color: AppColors.emeraldLive,
                ),
              ),
            ),
            const BadgeChip(
              label: '140/140 PUB POINTS',
              textColor: AppColors.amberBadge,
              borderColor: AppColors.border,
            ),
            const BadgeChip(
              label: 'MIT LICENSE',
              textColor: AppColors.textSecondary,
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Main Title
        Text(
          pkg.title,
          style: AppTypography.displayBold(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        if (pkg.subtitle.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            pkg.subtitle,
            style: AppTypography.monoBold(
              fontSize: 13,
              color: AppColors.flutterCyan,
            ),
          ),
        ],
        const SizedBox(height: 14),

        // Description
        Text(
          pkg.description,
          style: AppTypography.sans(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 18),

        // Compliance Guidelines Checklist Row
        Text(
          'STRICT REGULATORY COMPLIANCE BUILT-IN:',
          style: AppTypography.mono(
            fontSize: 10,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: pkg.complianceBadges.map((badge) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF141418),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.borderBright),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified_outlined,
                    size: 11,
                    color: AppColors.emeraldLive,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    badge,
                    style: AppTypography.mono(
                      fontSize: 11,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Tags
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: pkg.tags.map((tag) => BadgeChip(label: tag)).toList(),
        ),
        const SizedBox(height: 26),

        // Action Buttons Row
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            PrimaryButton(
              label: 'VIEW ON PUB.DEV',
              variant: ButtonVariant.primary,
              icon: Icons.rocket_launch_outlined,
              onPressed: () => UrlLauncherHelper.launchURL(pkg.pubDevUrl),
            ),
            PrimaryButton(
              label: 'MEDIUM BLOG',
              variant: ButtonVariant.outline,
              icon: Icons.article_outlined,
              showArrow: false,
              onPressed: () => UrlLauncherHelper.launchURL('https://medium.com/@codernta'),
            ),
            PrimaryButton(
              label: 'PACKAGE SOURCE',
              variant: ButtonVariant.outline,
              icon: Icons.code,
              onPressed: () => UrlLauncherHelper.launchURL(pkg.repositoryUrl),
            ),
            PrimaryButton(
              label: 'COPY PUB SPEC',
              variant: ButtonVariant.subtle,
              icon: Icons.copy,
              showArrow: false,
              onPressed: () => _copyDependency(context),
            ),
          ],
        ),
      ],
    );
  }
}

class _ComplianceTrustBanner extends StatelessWidget {
  final bool isMobile;

  const _ComplianceTrustBanner({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.flutterCyan.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.flutterCyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('🛡️', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '100% PURE DART & FLUTTER // ZERO EXTERNAL DEPENDENCIES',
                  style: AppTypography.monoBold(
                    fontSize: 12,
                    color: AppColors.flutterCyan,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'No transitive dependency vulnerabilities, license conflicts, or bloat. Complies with RBI Card-on-File Tokenization (CoFT), NPCI UPI ₹1L–₹5L transaction limit caps, UIDAI Verhoeff Aadhaar verification, PCI DSS 4.0 data masking, and DPDP Act 2023 memory redactions.',
                  style: AppTypography.sans(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FintechInteractiveSandbox extends StatefulWidget {
  const _FintechInteractiveSandbox();

  @override
  State<_FintechInteractiveSandbox> createState() =>
      _FintechInteractiveSandboxState();
}

class _FintechInteractiveSandboxState
    extends State<_FintechInteractiveSandbox> {
  int _activeTab = 0;
  bool _maskPii = true;
  int _selectedPaise = 15000000; // ₹1,50,000

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF09090C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Terminal Window Titlebar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF141418),
              borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: AppColors.terminalRed,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: AppColors.terminalYellow,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: AppColors.terminalGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'bharat_fx_engine.dart // Live Interactive Preview',
                    style: AppTypography.mono(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.emeraldLive.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'PURE DART',
                    style: AppTypography.monoBold(
                      fontSize: 9,
                      color: AppColors.emeraldLive,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Interactive Mode Switcher Tabs
          Container(
            color: const Color(0xFF0F0F13),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _SandboxTab(
                    label: '🛡️ Security & PII',
                    isSelected: _activeTab == 0,
                    onTap: () => setState(() => _activeTab = 0),
                  ),
                  const SizedBox(width: 6),
                  _SandboxTab(
                    label: '💰 BharatMoney',
                    isSelected: _activeTab == 1,
                    onTap: () => setState(() => _activeTab = 1),
                  ),
                  const SizedBox(width: 6),
                  _SandboxTab(
                    label: '🆔 IDs & Merged IFSC',
                    isSelected: _activeTab == 2,
                    onTap: () => setState(() => _activeTab = 2),
                  ),
                  const SizedBox(width: 6),
                  _SandboxTab(
                    label: '🧾 GST & Fiscal',
                    isSelected: _activeTab == 3,
                    onTap: () => setState(() => _activeTab = 3),
                  ),
                ],
              ),
            ),
          ),

          // Active Tab Content Area
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildActiveSandboxContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSandboxContent() {
    switch (_activeTab) {
      case 0:
        return _buildSecuritySandbox();
      case 1:
        return _buildMoneySandbox();
      case 2:
        return _buildIdentitySandbox();
      case 3:
      default:
        return _buildGstSandbox();
    }
  }

  // TAB 1: BharatSecurity
  Widget _buildSecuritySandbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '// PII REDACTION & TIMING-SAFE AUDIT',
              style: AppTypography.mono(
                fontSize: 11,
                color: AppColors.flutterCyan,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _maskPii = !_maskPii),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _maskPii
                      ? AppColors.emeraldLive.withValues(alpha: 0.15)
                      : AppColors.terminalRed.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _maskPii
                        ? AppColors.emeraldLive.withValues(alpha: 0.4)
                        : AppColors.terminalRed.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  _maskPii ? '🔒 MASKED (DPDP Compliant)' : '⚠️ RAW LEAK (Tap to Redact)',
                  style: AppTypography.monoBold(
                    fontSize: 10,
                    color: _maskPii ? AppColors.emeraldLive : AppColors.terminalRed,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF050507),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderMuted),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TerminalLine(
                prefix: '✓ TimingSafe.verify()',
                text: 'Constant-time MPIN comparison: 0.0012ms',
                textColor: AppColors.emeraldLive,
              ),
              _TerminalLine(
                prefix: '✓ SensitiveValue<T>',
                text: 'Zeroizable RAM wrapper active: 0 leaks in heap',
                textColor: AppColors.cyanAccent,
              ),
              const Divider(color: Color(0xFF1C1C22), height: 16),
              _TerminalLine(
                prefix: 'Aadhaar (UIDAI)',
                text: _maskPii ? '4532 •••• •••• 8912' : '4532 9981 7721 8912',
                textColor: _maskPii ? AppColors.textPrimary : AppColors.terminalYellow,
              ),
              _TerminalLine(
                prefix: 'PAN Card',
                text: _maskPii ? 'ABCDE••••F' : 'ABCDE1234F',
                textColor: _maskPii ? AppColors.textPrimary : AppColors.terminalYellow,
              ),
              _TerminalLine(
                prefix: 'Payment Card',
                text: _maskPii ? '6071 •••• •••• 7890 (RuPay)' : '6071 5212 9988 7890 (RuPay)',
                textColor: _maskPii ? AppColors.textPrimary : AppColors.terminalYellow,
              ),
              _TerminalLine(
                prefix: 'UPI Intent VPA',
                text: _maskPii ? 'r•••••••••@okaxis' : 'rohit.sharma@okaxis',
                textColor: _maskPii ? AppColors.textPrimary : AppColors.terminalYellow,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Pure-Dart RFC 6234 SHA-256 HMAC verification: 0 external C/C++ FFI dependencies.',
          style: AppTypography.mono(
            fontSize: 10,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  // TAB 2: BharatMoney & Indian Currency
  Widget _buildMoneySandbox() {
    final rupeeAmount = (_selectedPaise / 100).toStringAsFixed(2);
    final inLakhs = (_selectedPaise / 10000000).toStringAsFixed(2);
    final isUpiStdValid = _selectedPaise <= 10000000; // <= ₹1L
    final isUpiCapValid = _selectedPaise <= 20000000; // <= ₹2L
    final isImpsValid = _selectedPaise <= 50000000; // <= ₹5L

    String wordsEnglish = '';
    String wordsHindi = '';
    if (_selectedPaise == 500000) {
      wordsEnglish = 'Five Thousand Rupees Only';
      wordsHindi = 'पांच हज़ार रुपये';
    } else if (_selectedPaise == 15000000) {
      wordsEnglish = 'One Lakh Fifty Thousand Rupees Only';
      wordsHindi = 'एक लाख पचास हज़ार रुपये';
    } else if (_selectedPaise == 35000000) {
      wordsEnglish = 'Three Lakh Fifty Thousand Rupees Only';
      wordsHindi = 'तीन लाख पचास हज़ार रुपये';
    } else {
      wordsEnglish = 'Six Lakh Rupees Only';
      wordsHindi = 'छह लाख रुपये';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '// EXACT INTEGER PAISE ENGINE (NO FLOAT BUGS)',
              style: AppTypography.mono(
                fontSize: 11,
                color: AppColors.flutterCyan,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '1 INR = 100 Paise',
              style: AppTypography.mono(
                fontSize: 10,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Select Amount Chips
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _AmountButton(
              label: '₹5,000',
              isSelected: _selectedPaise == 500000,
              onTap: () => setState(() => _selectedPaise = 500000),
            ),
            _AmountButton(
              label: '₹1,50,000',
              isSelected: _selectedPaise == 15000000,
              onTap: () => setState(() => _selectedPaise = 15000000),
            ),
            _AmountButton(
              label: '₹3,50,000',
              isSelected: _selectedPaise == 35000000,
              onTap: () => setState(() => _selectedPaise = 35000000),
            ),
            _AmountButton(
              label: '₹6,00,000',
              isSelected: _selectedPaise == 60000000,
              onTap: () => setState(() => _selectedPaise = 60000000),
            ),
          ],
        ),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF050507),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderMuted),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TerminalLine(
                prefix: 'Paise Value',
                text: '$_selectedPaise Integer Units (0 IEEE 754 drift)',
                textColor: AppColors.cyanAccent,
              ),
              _TerminalLine(
                prefix: 'Lakh Scale',
                text: '₹$inLakhs Lakh (Format: ₹$rupeeAmount)',
                textColor: Colors.white,
              ),
              _TerminalLine(
                prefix: 'In Words (EN)',
                text: wordsEnglish,
                textColor: AppColors.textSecondary,
              ),
              _TerminalLine(
                prefix: 'In Words (HI)',
                text: wordsHindi,
                textColor: AppColors.textSecondary,
              ),
              const Divider(color: Color(0xFF1C1C22), height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _LimitBadge(
                    label: 'UPI Standard (₹1L)',
                    isPass: isUpiStdValid,
                  ),
                  _LimitBadge(
                    label: 'UPI Capital Mkts (₹2L)',
                    isPass: isUpiCapValid,
                  ),
                  _LimitBadge(
                    label: 'IMPS (₹5L)',
                    isPass: isImpsValid,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TAB 3: Identity & Merged IFSC
  Widget _buildIdentitySandbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// VERHOEFF CHECKSUM & MERGED BANK IFSC ADVISORY',
          style: AppTypography.mono(
            fontSize: 11,
            color: AppColors.flutterCyan,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF050507),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderMuted),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TerminalLine(
                prefix: 'Aadhaar Verhoeff',
                text: '4532 8912 3456 -> Checksum VALID (Official UIDAI)',
                textColor: AppColors.emeraldLive,
              ),
              _TerminalLine(
                prefix: 'Masked Result',
                text: '•••• •••• 3456 (Privacy Mask Applied)',
                textColor: AppColors.textSecondary,
              ),
              const Divider(color: Color(0xFF1C1C22), height: 16),
              _TerminalLine(
                prefix: 'IFSC Input',
                text: 'ALLA0210001 (Old Allahabad Bank)',
                textColor: AppColors.terminalYellow,
              ),
              _TerminalLine(
                prefix: 'Status Advisory',
                text: '⚠️ Merged into Indian Bank -> Successor: IDIB000A150',
                textColor: AppColors.flutterCyan,
              ),
              const Divider(color: Color(0xFF1C1C22), height: 16),
              _TerminalLine(
                prefix: 'MoRTH DL Parser',
                text: 'DL-1420110012345 -> State: Delhi (DL), RTO: 14, Year: 2011',
                textColor: AppColors.textPrimary,
              ),
              _TerminalLine(
                prefix: 'MCA CIN Parser',
                text: 'U72200DL2021PTC123456 -> Unlisted Private Tech Co.',
                textColor: AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TAB 4: GST & Fiscal Calendar
  Widget _buildGstSandbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// GST SPLIT ENGINE & INDIAN FISCAL CALENDAR',
          style: AppTypography.mono(
            fontSize: 11,
            color: AppColors.flutterCyan,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF050507),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderMuted),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TerminalLine(
                prefix: 'Taxable Base',
                text: '₹10,000.00 (1,000,000 Paise) @ 18% GST',
                textColor: Colors.white,
              ),
              _TerminalLine(
                prefix: 'Intra-State',
                text: 'CGST 9% (₹900.00) + SGST 9% (₹900.00)',
                textColor: AppColors.emeraldLive,
              ),
              _TerminalLine(
                prefix: 'Inter-State',
                text: 'IGST 18% (₹1,800.00)',
                textColor: AppColors.cyanAccent,
              ),
              const Divider(color: Color(0xFF1C1C22), height: 16),
              _TerminalLine(
                prefix: 'Fiscal Year',
                text: 'FY 2024-25 (Assessment Year: AY 2025-26)',
                textColor: AppColors.textPrimary,
              ),
              _TerminalLine(
                prefix: 'Advance Tax Due',
                text: 'June 15 (15%), Sep 15 (45%), Dec 15 (75%), Mar 15 (100%)',
                textColor: AppColors.textSecondary,
              ),
              _TerminalLine(
                prefix: 'Settlement Engine',
                text: 'T+1 & T+2 Market Settlement with RBI Holiday calendar',
                textColor: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SandboxTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SandboxTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1B1B22) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? AppColors.flutterCyan : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.monoBold(
            fontSize: 11,
            color: isSelected ? Colors.white : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _TerminalLine extends StatelessWidget {
  final String prefix;
  final String text;
  final Color textColor;

  const _TerminalLine({
    required this.prefix,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              prefix,
              style: AppTypography.mono(
                fontSize: 11,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTypography.mono(
                fontSize: 11,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _AmountButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.flutterCyan.withValues(alpha: 0.15)
              : const Color(0xFF141418),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? AppColors.flutterCyan : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.monoBold(
            fontSize: 11,
            color: isSelected ? AppColors.flutterCyan : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _LimitBadge extends StatelessWidget {
  final String label;
  final bool isPass;

  const _LimitBadge({
    required this.label,
    required this.isPass,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: isPass
              ? AppColors.emeraldLive.withValues(alpha: 0.1)
              : AppColors.terminalRed.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isPass
                ? AppColors.emeraldLive.withValues(alpha: 0.3)
                : AppColors.terminalRed.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          '${isPass ? "✓" : "✕"} $label',
          style: AppTypography.mono(
            fontSize: 9,
            color: isPass ? AppColors.emeraldLive : AppColors.terminalRed,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _HighlightsGrid extends StatelessWidget {
  final List<PackageModuleHighlight> highlights;
  final bool isDesktop;

  const _HighlightsGrid({
    required this.highlights,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = isDesktop ? 2 : 1;
        final cardWidth =
            (constraints.maxWidth - ((crossAxisCount - 1) * 20)) / crossAxisCount;

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: highlights.map((module) {
            return SizedBox(
              width: cardWidth,
              child: _HighlightCard(module: module),
            );
          }).toList(),
        );
      },
    );
  }
}

class _HighlightCard extends StatefulWidget {
  final PackageModuleHighlight module;

  const _HighlightCard({required this.module});

  @override
  State<_HighlightCard> createState() => _HighlightCardState();
}

class _HighlightCardState extends State<_HighlightCard> {
  bool _showCode = false;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Title + Class chip
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.module.icon,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.module.title,
                      style: AppTypography.sansBold(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.flutterCyan.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.flutterCyan.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Text(
                        widget.module.moduleClass,
                        style: AppTypography.mono(
                          fontSize: 11,
                          color: AppColors.flutterCyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Summary
          Text(
            widget.module.summary,
            style: AppTypography.sans(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          const Divider(color: Color(0xFF1E1E24), height: 1),
          const SizedBox(height: 14),

          // Bullet points
          ...widget.module.bulletPoints.map((point) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5, right: 8),
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.flutterCyan,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: AppTypography.sans(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          // Code snippet expander
          if (widget.module.codeSnippet.isNotEmpty) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => setState(() => _showCode = !_showCode),
              child: Row(
                children: [
                  Icon(
                    _showCode ? Icons.expand_less : Icons.code,
                    size: 14,
                    color: AppColors.flutterCyan,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _showCode ? 'HIDE DART API CODE' : 'VIEW DART API USAGE',
                    style: AppTypography.monoBold(
                      fontSize: 10,
                      color: AppColors.flutterCyan,
                    ),
                  ),
                ],
              ),
            ),
            if (_showCode) ...[
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF09090C),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  widget.module.codeSnippet,
                  style: AppTypography.mono(
                    fontSize: 11,
                    color: const Color(0xFF7DD3FC),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
