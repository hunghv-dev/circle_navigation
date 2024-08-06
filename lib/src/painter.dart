import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  final double circleX;
  final double circleWidth;
  final double circleMargin;
  final double outlineRadius;
  final double navHeight;
  final BorderRadius cornerRadius;

  Painter({
    required this.circleX,
    required this.circleWidth,
    required this.circleMargin,
    required this.outlineRadius,
    required this.navHeight,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final navPath = Path()..moveTo(0, 0);

    final circleR = circleWidth / 2 + circleMargin;
    final start = circleX - circleR - outlineRadius;
    navPath.lineTo(start, 0);
    navPath.cubicTo(
        start + outlineRadius, 0, circleX - circleR, circleR, circleX, circleR);

    final end = circleX + circleR + outlineRadius;
    navPath.cubicTo(circleX + circleR, circleR, end - outlineRadius, 0, end, 0);

    final width = size.width;
    navPath.lineTo(width, 0);
    navPath.lineTo(width, navHeight);
    navPath.lineTo(0, navHeight);
    navPath.close();

    final navPaint = Paint();
    navPaint.color = Colors.grey;

    canvas.drawPath(navPath, navPaint);

    canvas.drawCircle(
        Offset(circleX, 0), circleWidth / 2, Paint()..color = Colors.green.withOpacity(0.5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
