import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  /// X-coordinate of the circle's center
  final double circleX;

  /// Diameter of the circle
  final double circleWidth;

  /// Space margin around the circle
  final double circleMargin;

  /// Radius of the outline both sides below the circle
  final double outlineRadius;

  /// Corner radius of navigation bar
  final BorderRadius cornerRadius;

  /// Color of the navigation bar
  final Color navColor;

  /// Color of the circle
  final Color circleColor;

  const Painter({
    required this.circleX,
    required this.circleWidth,
    required this.circleMargin,
    required this.outlineRadius,
    required this.cornerRadius,
    required this.navColor,
    required this.circleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final navPath = Path();
    // Start drawing the path from the top-left corner
    navPath.moveTo(0, cornerRadius.topLeft.y);
    navPath.quadraticBezierTo(0, 0, cornerRadius.topLeft.x, 0);
    // Calculate the radius of the circle including the margin
    final circleR = circleWidth / 2 + circleMargin;
    final startX = circleX - circleR - outlineRadius;
    // Draw the left curve leading to the circle
    navPath.lineTo(startX, 0);
    navPath.cubicTo(startX + outlineRadius, 0, circleX - circleR, circleR,
        circleX, circleR);
    // Draw the right curve leading away from the circle
    final endX = circleX + circleR + outlineRadius;
    navPath.cubicTo(
        circleX + circleR, circleR, endX - outlineRadius, 0, endX, 0);
    // Continue drawing the path to the top-right corner
    final width = size.width;
    final height = size.height;
    navPath.lineTo(width - cornerRadius.topRight.x, 0);
    navPath.quadraticBezierTo(width, 0, width, cornerRadius.topRight.y);
    // Draw the right side and bottom of the navigation bar
    navPath.lineTo(width, height - cornerRadius.bottomRight.y);
    navPath.quadraticBezierTo(
        width, height, width - cornerRadius.bottomRight.x, height);
    navPath.lineTo(cornerRadius.bottomLeft.x, height);
    navPath.quadraticBezierTo(0, height, 0, height - cornerRadius.bottomLeft.y);
    navPath.close();
    // Draw the navigation bar path
    canvas.drawPath(navPath, Paint()..color = navColor);
    // Draw the circle at the circleX position
    canvas.drawCircle(
      Offset(circleX, 0),
      circleWidth / 2,
      Paint()..color = circleColor,
    );
  }

  @override
  bool shouldRepaint(covariant Painter oldDelegate) => this != oldDelegate;
}
