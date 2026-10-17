import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Custom painter rendering architectural drafting paper grid lines.
class ArchitecturalGridPainter extends CustomPainter {
  final Color backgroundColor;
  final Color gridLineColor;
  final double cellSize;
  final double strokeWidth;

  const ArchitecturalGridPainter({
    this.backgroundColor = AppColors.gridPaper,
    this.gridLineColor = AppColors.gridLine,
    this.cellSize = 44.0,
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Paint paper background
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, bgPaint);

    // 2. Paint grid lines
    final linePaint = Paint()
      ..color = gridLineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Vertical lines
    for (double x = 0; x <= size.width; x += cellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += cellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant ArchitecturalGridPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.gridLineColor != gridLineColor ||
        oldDelegate.cellSize != cellSize ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
