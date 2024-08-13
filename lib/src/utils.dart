import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  /// Getter to retrieve the screen width using MediaQuery
  double get _screenWidth => MediaQuery.of(this).size.width;

  /// Method to calculate the horizontal offset based on a percentage of the screen width
  double offsetX(double percent) => percent * _screenWidth;

  /// Method to calculate the position percentage of an item in a list
  /// If trim is null, it returns a uniform distribution percentage
  /// Otherwise, it calculates the percentage based on the provided trim
  double percent(double? trim, int index, int total) => trim == null
      ? (index + 1) / (total + 1)
      : ((index - (total - 1) * 0.5) * (_screenWidth - 2 * trim)) /
              (_screenWidth * (total - 1)) +
          0.5;
}
