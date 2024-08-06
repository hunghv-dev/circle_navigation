import 'package:flutter/material.dart';

import 'painter.dart';

class CircleNavigation extends StatelessWidget {
  final double height;

  const CircleNavigation({super.key, this.height = 80});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: Painter(
          circleWidth: 100,
          circleMargin: 0,
          outlineRadius: 0,
          navHeight: height,
          cornerRadius: BorderRadius.circular(10),
          circleX: screenWidth * 0.25,
        ),
      ),
    );
  }
}
