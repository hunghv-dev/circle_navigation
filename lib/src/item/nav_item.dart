import 'package:flutter/material.dart';
import 'item.dart';

class NavItem extends StatelessWidget {
  final Item item;
  final TextStyle? textStyle;
  final double textPadding;
  final VoidCallback? onTap;
  final bool selected;
  final double circleWidth;
  final double circleMargin;
  final Curve curve;
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
            AnimatedOpacity(
              opacity: selected ? 1 : 0,
              duration: Duration(milliseconds: (duration * 0.5).toInt()),
              curve: curve,
              child: Padding(
                padding: EdgeInsets.only(top: textPadding),
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
