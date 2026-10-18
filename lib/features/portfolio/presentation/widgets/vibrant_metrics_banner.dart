import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/responsive_layout.dart';

class VibrantMetricsBanner extends StatelessWidget {
  const VibrantMetricsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
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
                    _buildStatItem('4+ Years', 'SENIOR EXPERIENCE'),
                    _buildDivider(),
                    _buildStatItem('0 Days', 'NOTICE PERIOD (IMMEDIATE)'),
                    _buildDivider(),
                    _buildStatItem('5+ Apps', 'LIVE ON PLAY STORE'),
                    _buildDivider(),
                    _buildStatItem('Bharat FX', 'PUB.DEV PACKAGE AUTHOR'),
                  ],
                )
              : Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    SizedBox(
                      width: isMobile ? 140 : 180,
                      child: _buildStatItem('4+ Years', 'SENIOR EXPERIENCE', isFlex: false),
                    ),
                    SizedBox(
                      width: isMobile ? 140 : 180,
                      child: _buildStatItem('0 Days', 'NOTICE (IMMEDIATE)', isFlex: false),
                    ),
                    SizedBox(
                      width: isMobile ? 140 : 180,
                      child: _buildStatItem('5+ Apps', 'LIVE ON PLAY STORE', isFlex: false),
                    ),
                    SizedBox(
                      width: isMobile ? 140 : 180,
                      child: _buildStatItem('Bharat FX', 'PUB.DEV PACKAGE', isFlex: false),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, {bool isFlex = true}) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          textAlign: TextAlign.center,
          style: AppTypography.displayBold(
            fontSize: 30,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.monoBold(
            fontSize: 10,
            color: const Color(0xCC000000),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );

    if (isFlex) {
      return Expanded(flex: 1, child: content);
    }
    return content;
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 44,
      color: Colors.black.withValues(alpha: 0.25),
    );
  }
}
