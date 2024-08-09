import 'package:flutter/material.dart';

class Item {
  /// The icon widget for the item
  final Widget icon;

  /// The label for the item, defaulting to an empty string
  final String label;

  Item({required this.icon, this.label = ''});
}
