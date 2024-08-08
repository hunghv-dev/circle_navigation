import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  double get _screenWidth => MediaQuery.of(this).size.width;

  double offsetX(double percent) => percent * _screenWidth;

  double percent(double? spacing, int index, int total) => spacing == null
      ? (index + 1) / (total + 1)
      : (index - (total - 1) * 0.5) * spacing / _screenWidth + 0.5;
}
