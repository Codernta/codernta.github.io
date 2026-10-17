import 'package:flutter/material.dart';

/// Custom painter rendering the subtle dot grid background seen in the Stitch UI design.
class CyberDotsPainter extends CustomPainter {
  final Color dotColor;
  final double spacing;
  final double radius;

  CyberDotsPainter({
    this.dotColor = const Color(0x14FFFFFF), // ~8% opacity white
    this.spacing = 32.0,
    this.radius = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CyberDotsPainter oldDelegate) {
    return oldDelegate.dotColor != dotColor ||
        oldDelegate.spacing != spacing ||
        oldDelegate.radius != radius;
  }
}
