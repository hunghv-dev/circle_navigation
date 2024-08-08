import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  final double circleX;
  final double circleWidth;
  final double circleMargin;
  final double outlineRadius;
  final BorderRadius cornerRadius;
  final Color navColor;
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

    navPath.moveTo(0, cornerRadius.topLeft.y);
    navPath.quadraticBezierTo(0, 0, cornerRadius.topLeft.x, 0);

    final circleR = circleWidth / 2 + circleMargin;
    final startX = circleX - circleR - outlineRadius;
    navPath.lineTo(startX, 0);
    navPath.cubicTo(startX + outlineRadius, 0, circleX - circleR, circleR,
        circleX, circleR);

    final endX = circleX + circleR + outlineRadius;
    navPath.cubicTo(
        circleX + circleR, circleR, endX - outlineRadius, 0, endX, 0);

    final width = size.width;
    final height = size.height;
    navPath.lineTo(width - cornerRadius.topRight.x, 0);
    navPath.quadraticBezierTo(width, 0, width, cornerRadius.topRight.y);
    navPath.lineTo(width, height - cornerRadius.bottomRight.y);
    navPath.quadraticBezierTo(
        width, height, width - cornerRadius.bottomRight.x, height);
    navPath.lineTo(cornerRadius.bottomLeft.x, height);
    navPath.quadraticBezierTo(0, height, 0, height - cornerRadius.bottomLeft.y);
    navPath.close();

    canvas.drawPath(navPath, Paint()..color = navColor);

    canvas.drawCircle(
      Offset(circleX, 0),
      circleWidth / 2,
      Paint()..color = circleColor,
    );
  }

  @override
  bool shouldRepaint(covariant Painter oldDelegate) => this != oldDelegate;
}
