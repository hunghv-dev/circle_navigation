import 'package:flutter/material.dart';
import 'item.dart';

class NavItem extends StatelessWidget {
  /// The item to be displayed
  final Item item;

  /// Optional text style for the label
  final TextStyle? textStyle;

  /// Space padding from label to icon of item
  final double textPadding;

  /// Callback for tap to item
  final VoidCallback? onTap;

  /// Whether the item is selected
  final bool selected;

  /// Width of the circle
  final double circleWidth;

  /// Space margin around the circle
  final double circleMargin;

  /// Animation curve
  final Curve curve;

  /// Duration of the animation
  final int duration;

  const NavItem({
    super.key,
    required this.item,
    this.textStyle,
    required this.textPadding,
    required this.onTap,
    required this.selected,
    required this.circleWidth,
    required this.circleMargin,
    required this.curve,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: circleWidth / 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Vertical animated slide for the icon
            AnimatedSlide(
              offset: Offset(0, selected ? -0.5 : 1),
              duration: Duration(milliseconds: (duration * 1.1).toInt()),
              curve: curve,
              child: GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.translucent,
                child: item.icon,
              ),
            ),
            SizedBox(height: circleWidth / 2 + circleMargin),
            // Animated opacity for the label
            AnimatedOpacity(
              opacity: selected ? 1 : 0,
              duration: Duration(milliseconds: (duration * 0.5).toInt()),
              curve: curve,
              child: Padding(
                padding: EdgeInsets.only(top: textPadding),
                // Vertical animated slide for the label
                child: AnimatedSlide(
                  offset: Offset(0, selected ? -1 : 1),
                  duration: Duration(milliseconds: (duration * 1.2).toInt()),
                  curve: Curves.ease,
                  child: Text(
                    item.label,
                    style: textStyle,
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
