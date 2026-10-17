import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../../../../core/widgets/architectural_grid_painter.dart';
import '../../domain/entities/developer_profile.dart';
import '../controllers/portfolio_controller.dart';

class HeroSection extends StatelessWidget {
  final DeveloperProfile profile;
  final PortfolioController controller;

  const HeroSection({
    super.key,
    required this.profile,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      key: controller.heroKey,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 20 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Top Outer Editorial Metadata Bar (from inspiration design)
          _OuterMetadataHeader(isDesktop: isDesktop),
          const SizedBox(height: 12),

          // 2. Main Dark Card Container
          Container(
            decoration: BoxDecoration(
              color: AppColors.canvasDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderBright, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 36,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            padding: EdgeInsets.all(isMobile ? 18 : 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top In-Canvas Header / Brand & Nav Links
                _InCanvasHeader(
                  controller: controller,
                  isDesktop: isDesktop,
                ),
                SizedBox(height: isMobile ? 24 : 36),

                // Massive Headline: "FLUTTER DEVELOPER"
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FLUTTER DEVELOPER',
                    style: AppTypography.headlineCondensed(
                      fontSize: isMobile ? 64 : 124,
                      color: Colors.white,
                      letterSpacing: isMobile ? 1.5 : 3.0,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 18 : 28),

                // 3-Column Paragraphs & CTA Band
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column 1: Current Company / Role
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Senior Flutter Developer currently orchestrating AI-powered and BLE cross-platform mobile apps at IIC WebSolutions, based in Trivandrum, Kerala.',
                          style: AppTypography.sans(
                            fontSize: 14.5,
                            color: AppColors.textSecondary,
                            height: 1.55,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),

                      // Column 2: Architecture & Performance Mission
                      Expanded(
                        flex: 5,
                        child: Text(
                          'Passionate mobile architect with 4+ years shipping scalable apps using Clean Architecture, BLoC, OpenAI integrations, Socket.IO, and zero-compromise 60fps performance.',
                          style: AppTypography.sans(
                            fontSize: 14.5,
                            color: AppColors.textSecondary,
                            height: 1.55,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),

                      // Column 3: "GET IN TOUCH →" CTA
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: _GetInTouchButton(controller: controller),
                        ),
                      ),
                    ],
                  )
                else ...[
                  Text(
                    'Senior Flutter Developer currently orchestrating AI-powered and BLE cross-platform apps at IIC WebSolutions, based in Trivandrum, Kerala.',
                    style: AppTypography.sans(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '4+ years shipping scalable Android & iOS apps with Clean Architecture, BLoC, OpenAI APIs, Socket.IO, and store release lifecycle.',
                    style: AppTypography.sans(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _GetInTouchButton(controller: controller),
                  ),
                ],

                SizedBox(height: isMobile ? 24 : 36),

                // 3. Centerpiece Creative Canvas: Architectural Grid + Photo + Decal Badges
                _HeroStageCanvas(
                  isDesktop: isDesktop,
                  isMobile: isMobile,
                  controller: controller,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          // 4. Bottom Outer Editorial Metadata Bar (from inspiration design)
          _OuterMetadataFooter(isMobile: isMobile),
        ],
      ),
    );
  }
}

/// Top editorial header outside the card container (matches inspiration image)
class _OuterMetadataHeader extends StatelessWidget {
  final bool isDesktop;

  const _OuterMetadataHeader({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    if (!isDesktop) {
      return Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: [
          Text(
            'NITHIN TA',
            style: AppTypography.monoBold(
              fontSize: 11,
              color: AppColors.outerFrameText,
              letterSpacing: 0.8,
            ),
          ),
          Text(
            'FLUTTER ARCHITECT',
            style: AppTypography.mono(
              fontSize: 10,
              color: AppColors.outerFrameText.withValues(alpha: 0.7),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Portfolio Design',
              style: AppTypography.sansBold(
                fontSize: 12,
                color: AppColors.outerFrameText,
              ),
            ),
            Text(
              'Exploration',
              style: AppTypography.sans(
                fontSize: 12,
                color: AppColors.outerFrameText.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
        Text(
          'Nithin TA',
          style: AppTypography.sansBold(
            fontSize: 13,
            color: AppColors.outerFrameText,
            letterSpacing: 0.5,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'SENIOR FLUTTER DEV',
              style: AppTypography.monoBold(
                fontSize: 11,
                color: AppColors.outerFrameText,
              ),
            ),
            Text(
              '— 2026',
              style: AppTypography.mono(
                fontSize: 11,
                color: AppColors.outerFrameText.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Bottom editorial footer outside the card container (matches inspiration image)
class _OuterMetadataFooter extends StatelessWidget {
  final bool isMobile;

  const _OuterMetadataFooter({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 6,
      children: [
        Text(
          isMobile
              ? 'Senior Mobile Engineer'
              : 'Senior Flutter Developer & Open-Source Supporter',
          style: AppTypography.sans(
            fontSize: 12,
            color: AppColors.outerFrameText.withValues(alpha: 0.85),
          ),
        ),
        Text(
          '©\'22 — Present',
          style: AppTypography.mono(
            fontSize: 11,
            color: AppColors.outerFrameText.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }
}

/// In-canvas header with pill logo on left and direct navigation links on right
class _InCanvasHeader extends StatelessWidget {
  final PortfolioController controller;
  final bool isDesktop;

  const _InCanvasHeader({
    required this.controller,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: Monogram Pill Capsule Logo
        InkWell(
          onTap: () => controller.scrollToSection(controller.heroKey, 'hero'),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.canvasDark,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nithin TA',
                    style: AppTypography.sansBold(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Senior Flutter Dev',
                    style: AppTypography.mono(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Right: Nav Links (Desktop)
        if (isDesktop)
          Row(
            children: [
              _HeroNavLink(
                label: 'Work',
                onTap: () => controller.scrollToSection(
                    controller.projectsKey, 'projects'),
              ),
              const SizedBox(width: 24),
              _HeroNavLink(
                label: 'Experience',
                onTap: () => controller.scrollToSection(
                    controller.timelineKey, 'timeline'),
              ),
              const SizedBox(width: 24),
              _HeroNavLink(
                label: 'Open Source',
                onTap: () => controller.scrollToSection(
                    controller.openSourceKey, 'opensource'),
              ),
              const SizedBox(width: 24),
              _HeroNavLink(
                label: 'Contact',
                onTap: () => controller.scrollToSection(
                    controller.contactKey, 'contact'),
              ),
            ],
          ),
      ],
    );
  }
}

class _HeroNavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _HeroNavLink({required this.label, required this.onTap});

  @override
  State<_HeroNavLink> createState() => _HeroNavLinkState();
}

class _HeroNavLinkState extends State<_HeroNavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: AppTypography.sansMedium(
            fontSize: 14,
            color: _hovered ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

/// "GET IN TOUCH →" high-contrast button
class _GetInTouchButton extends StatefulWidget {
  final PortfolioController controller;

  const _GetInTouchButton({required this.controller});

  @override
  State<_GetInTouchButton> createState() => _GetInTouchButtonState();
}

class _GetInTouchButtonState extends State<_GetInTouchButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => widget.controller
            .scrollToSection(widget.controller.contactKey, 'contact'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: _hovered ? Colors.white : const Color(0xFF191920),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? Colors.white : AppColors.borderBright,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'GET IN TOUCH',
                style: AppTypography.monoBold(
                  fontSize: 12,
                  color: _hovered ? Colors.black : Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 15,
                color: _hovered ? Colors.black : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The centerpiece architectural drafting grid canvas with stadium arch & decals
class _HeroStageCanvas extends StatelessWidget {
  final bool isDesktop;
  final bool isMobile;
  final PortfolioController controller;

  const _HeroStageCanvas({
    required this.isDesktop,
    required this.isMobile,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double stageHeight = isDesktop ? 480 : (isMobile ? 420 : 460);

    return Container(
      height: stageHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.gridPaper,
        // The rounded stadium arch on the right (matching inspiration image)
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          bottomLeft: const Radius.circular(16),
          topRight: Radius.circular(isMobile ? 32 : 220),
          bottomRight: Radius.circular(isMobile ? 32 : 220),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          bottomLeft: const Radius.circular(16),
          topRight: Radius.circular(isMobile ? 32 : 220),
          bottomRight: Radius.circular(isMobile ? 32 : 220),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Architectural Grid Lines
            Positioned.fill(
              child: CustomPaint(
                painter: const ArchitecturalGridPainter(),
              ),
            ),

            // Center: Portrait of Nithin TA
            Positioned(
              bottom: 0,
              child: _PortraitImage(height: stageHeight * 0.92),
            ),

            // Floating Decal Stickers (Desktop Layout)
            if (isDesktop) ...[
              // 1. Top-Left: Cyan Circle Badge (Clean Architecture & BLoC)
              Positioned(
                top: 40,
                left: 60,
                child: _CyanCircleBadge(
                  onTap: () => controller.scrollToSection(
                      controller.timelineKey, 'timeline'),
                ),
              ),

              // 2. Mid-Left: Yellow Tilted Sticker (AI-Powered / OpenAI)
              Positioned(
                top: 170,
                left: 20,
                child: _YellowSticker(
                  onTap: () => controller.scrollToSection(
                      controller.timelineKey, 'timeline'),
                ),
              ),

              // 3. Bottom-Left: Orange Slanted Tag (Socket.IO / Real-Time)
              Positioned(
                bottom: 40,
                left: 70,
                child: _OrangeTag(
                  onTap: () => controller.scrollToSection(
                      controller.projectsKey, 'projects'),
                ),
              ),

              // 4. Top-Right: Pink Stamp Badge (BLE & Hardware Integration)
              Positioned(
                top: 70,
                right: 170,
                child: _PinkStamp(
                  onTap: () => controller.scrollToSection(
                      controller.timelineKey, 'timeline'),
                ),
              ),

              // 5. Mid-Right: Mint Slanted Ticket (Bharat FX / Pub.dev Package)
              Positioned(
                top: 180,
                right: 35,
                child: _MintTicket(
                  onTap: () => controller.scrollToSection(
                      controller.openSourceKey, 'opensource'),
                ),
              ),

              // 6. Bottom-Right: Neon Lime Circular Seal (4+ Years / Immediate)
              Positioned(
                bottom: 30,
                right: 120,
                child: _LimeSeal(
                  onTap: () => controller.scrollToSection(
                      controller.contactKey, 'contact'),
                ),
              ),
            ] else ...[
              // Tablet / Mobile simplified floating decals
              Positioned(
                top: 16,
                left: 16,
                child: _YellowSticker(
                  onTap: () => controller.scrollToSection(
                      controller.timelineKey, 'timeline'),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: _MintTicket(
                  onTap: () => controller.scrollToSection(
                      controller.openSourceKey, 'opensource'),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 20,
                child: _LimeSeal(
                  onTap: () => controller.scrollToSection(
                      controller.contactKey, 'contact'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Profile image rendering with clean cutout and graceful asset fallback
class _PortraitImage extends StatelessWidget {
  final double height;

  const _PortraitImage({required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/nithin_cutout.png',
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to original photo in a stylish pill frame
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            'assets/images/nithin_profile.png',
            height: height * 0.85,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

// ============================================================================
// NEO-BRUTALIST STICKER DECALS (Directly inspired by the attached image)
// ============================================================================

/// 1. Cyan Circular Badge: "CLEAN ARCHITECTURE / BLoC • GETX • PROVIDER"
class _CyanCircleBadge extends StatefulWidget {
  final VoidCallback onTap;

  const _CyanCircleBadge({required this.onTap});

  @override
  State<_CyanCircleBadge> createState() => _CyanCircleBadgeState();
}

class _CyanCircleBadgeState extends State<_CyanCircleBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Transform.rotate(
          angle: -6 * (math.pi / 180),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: _hovered ? 1.08 : 1.0,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.stickerCyan,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    offset: const Offset(3, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.layers_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'CLEAN\nARCHITECTURE',
                        textAlign: TextAlign.center,
                        style: AppTypography.sansBold(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'BLoC • GETX',
                        textAlign: TextAlign.center,
                        style: AppTypography.mono(
                          fontSize: 8,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 2. Yellow Tilted Sticker: "AI-POWERED ✦ / OPENAI APPS & AUTOMATION"
class _YellowSticker extends StatefulWidget {
  final VoidCallback onTap;

  const _YellowSticker({required this.onTap});

  @override
  State<_YellowSticker> createState() => _YellowStickerState();
}

class _YellowStickerState extends State<_YellowSticker> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Transform.rotate(
          angle: 4 * (math.pi / 180),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: _hovered ? 1.06 : 1.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.stickerYellow,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 2.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    offset: const Offset(3, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'AI-POWERED',
                        style: AppTypography.monoBold(
                          fontSize: 11,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          'OPENAI ✦',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'AUTOMATION & WORKFLOWS',
                    style: AppTypography.sansBold(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 3. Orange Slanted Tag: "REAL-TIME CHAT ➔ / SOCKET.IO & WEBSOCKETS"
class _OrangeTag extends StatefulWidget {
  final VoidCallback onTap;

  const _OrangeTag({required this.onTap});

  @override
  State<_OrangeTag> createState() => _OrangeTagState();
}

class _OrangeTagState extends State<_OrangeTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Transform.rotate(
          angle: -4 * (math.pi / 180),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: _hovered ? 1.06 : 1.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.stickerOrange,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 2.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(3, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '⚡ ',
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        'REAL-TIME CHAT',
                        style: AppTypography.monoBold(
                          fontSize: 11,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'SOCKET.IO ➔ WEBSOCKETS',
                        style: AppTypography.sansBold(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 4. Hot Pink Stamp Badge: "BLE & HARDWARE / BLUETOOTH LOW ENERGY"
class _PinkStamp extends StatefulWidget {
  final VoidCallback onTap;

  const _PinkStamp({required this.onTap});

  @override
  State<_PinkStamp> createState() => _PinkStampState();
}

class _PinkStampState extends State<_PinkStamp> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Transform.rotate(
          angle: 5 * (math.pi / 180),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: _hovered ? 1.06 : 1.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.stickerPink,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    offset: const Offset(3, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'BLE & HARDWARE',
                    style: AppTypography.monoBold(
                      fontSize: 11,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    'BLUETOOTH LOW ENERGY ©',
                    style: AppTypography.sansBold(
                      fontSize: 9,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 5. Mint Slanted Ticket: "BHARAT FX 🇮🇳 / PUB.DEV PACKAGE AUTHOR"
class _MintTicket extends StatefulWidget {
  final VoidCallback onTap;

  const _MintTicket({required this.onTap});

  @override
  State<_MintTicket> createState() => _MintTicketState();
}

class _MintTicketState extends State<_MintTicket> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Transform.rotate(
          angle: -7 * (math.pi / 180),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: _hovered ? 1.06 : 1.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.stickerMint,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 2.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    offset: const Offset(3, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'BHARAT FX 🇮🇳',
                        style: AppTypography.sansBold(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.auto_awesome,
                        size: 13,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'PUB.DEV AUTHOR ©\'26',
                    style: AppTypography.monoBold(
                      fontSize: 9,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 6. Lime Green Seal: "4+ YEARS EXP ★ 5+ LIVE APPS ★ 0d NOTICE"
class _LimeSeal extends StatefulWidget {
  final VoidCallback onTap;

  const _LimeSeal({required this.onTap});

  @override
  State<_LimeSeal> createState() => _LimeSealState();
}

class _LimeSealState extends State<_LimeSeal> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Transform.rotate(
          angle: 9 * (math.pi / 180),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: _hovered ? 1.08 : 1.0,
            child: Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                color: AppColors.stickerLime,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(3, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified,
                        size: 18,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '4+ YEARS',
                        textAlign: TextAlign.center,
                        style: AppTypography.sansBold(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '5+ APPS • 0d NOTICE',
                        textAlign: TextAlign.center,
                        style: AppTypography.mono(
                          fontSize: 7.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
