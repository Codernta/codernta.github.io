import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';

class VibrantMetricsBanner extends StatefulWidget {
  const VibrantMetricsBanner({super.key});

  @override
  State<VibrantMetricsBanner> createState() => _VibrantMetricsBannerState();
}

class _VibrantMetricsBannerState extends State<VibrantMetricsBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sheenController;

  @override
  void initState() {
    super.initState();
    _sheenController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _sheenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Stack(
      children: [
        // Base Vibrant Green Container
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.neonGreen,
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 24 : 32,
            horizontal: isMobile ? 16 : 32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: isDesktop
                  ? Row(
                      children: [
                        _AnimatedStatItem(
                          numericTarget: 4,
                          suffix: '+ Years',
                          label: 'SENIOR EXPERIENCE',
                        ),
                        _buildDivider(),
                        _AnimatedStatItem(
                          numericTarget: 0,
                          suffix: ' Days',
                          label: 'NOTICE PERIOD (IMMEDIATE)',
                        ),
                        _buildDivider(),
                        _AnimatedStatItem(
                          numericTarget: 7,
                          suffix: '+ Apps',
                          label: 'LIVE ON PLAY STORE',
                        ),
                        _buildDivider(),
                        _AnimatedStatItem(
                          numericTarget: 2,
                          suffix: ' Pkgs',
                          label: 'PUB.DEV PACKAGES AUTHOR',
                        ),
                      ],
                    )
                  : Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 24,
                      runSpacing: 24,
                      children: [
                        SizedBox(
                          width: isMobile ? 140 : 180,
                          child: _AnimatedStatItem(
                            numericTarget: 4,
                            suffix: '+ Years',
                            label: 'SENIOR EXPERIENCE',
                            isFlex: false,
                          ),
                        ),
                        SizedBox(
                          width: isMobile ? 140 : 180,
                          child: _AnimatedStatItem(
                            numericTarget: 0,
                            suffix: ' Days',
                            label: 'NOTICE (IMMEDIATE)',
                            isFlex: false,
                          ),
                        ),
                        SizedBox(
                          width: isMobile ? 140 : 180,
                          child: _AnimatedStatItem(
                            numericTarget: 7,
                            suffix: '+ Apps',
                            label: 'LIVE ON PLAY STORE',
                            isFlex: false,
                          ),
                        ),
                        SizedBox(
                          width: isMobile ? 140 : 180,
                          child: _AnimatedStatItem(
                            numericTarget: 2,
                            suffix: ' Pkgs',
                            label: 'PUB.DEV PACKAGES',
                            isFlex: false,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),

        // Continuous Holographic Sweeping Sheen
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _sheenController,
              builder: (context, _) {
                final t = _sheenController.value;
                return FractionallySizedBox(
                  alignment: Alignment(-2.0 + (t * 4.0), 0.0),
                  widthFactor: 0.25,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.0),
                          Colors.white.withValues(alpha: 0.18),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 44,
      color: Colors.black.withValues(alpha: 0.25),
    );
  }
}

class _AnimatedStatItem extends StatefulWidget {
  final int numericTarget;
  final String? suffix;
  final String label;
  final bool isFlex;

  const _AnimatedStatItem({
    required this.numericTarget,
    this.suffix,
    required this.label,
    this.isFlex = true,
  });

  @override
  State<_AnimatedStatItem> createState() => _AnimatedStatItemState();
}

class _AnimatedStatItemState extends State<_AnimatedStatItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textWidget = TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: widget.numericTarget.toDouble()),
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeOutExpo,
      builder: (context, value, _) {
        final displayInt = value.round();
        final text = '$displayInt${widget.suffix ?? ''}';
        return Text(
          text,
          textAlign: TextAlign.center,
          style: AppTypography.displayBold(
            fontSize: 30,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        );
      },
    );

    final content = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textWidget,
            const SizedBox(height: 4),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: AppTypography.monoBold(
                fontSize: 10,
                color: const Color(0xCC000000),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );

    if (widget.isFlex) {
      return Expanded(flex: 1, child: content);
    }
    return content;
  }
}
