import 'package:flutter/material.dart';
import 'background/background.dart';
import 'item/item.dart';
import 'item/nav_item.dart';
import 'utils.dart';

class CircleNavigation extends StatefulWidget {
  /// Initial index of the selected item
  final int initIndex;

  /// List of navigation items
  final List<Item> items;

  /// Callback when the selected item changes
  final ValueSetter<int> onChange;

  /// Height of the navigation bar
  final double height;

  /// Optional horizontal spacing between items
  final double? itemSpacing;

  /// Width of the circle
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

  /// Text style for the item labels
  final TextStyle? textStyle;

  /// Space padding from label to icon of item
  final double textPadding;

  /// Animation curve
  final Curve curve;

  /// Duration of the animation in milliseconds
  final int duration;

  const CircleNavigation({
    super.key,
    this.initIndex = 0,
    required this.items,
    required this.onChange,
    this.height = 100,
    this.itemSpacing,
    this.circleWidth = 80,
    this.circleMargin = 5,
    this.outlineRadius = 30,
    this.cornerRadius = BorderRadius.zero,
    this.navColor = Colors.grey,
    this.circleColor = Colors.grey,
    this.textStyle,
    this.textPadding = 0.0,
    this.curve = Curves.ease,
    this.duration = 300,
  })  : assert(initIndex >= 0 && initIndex < items.length,
            'initIndex must be positive and less than items.length'),
        assert(items.length >= 2, 'items must have at least 2 elements'),
        assert(circleWidth > 0, 'circleWidth must be greater than 0'),
        assert(height > circleWidth, 'height must be greater than circleWidth'),
        assert(itemSpacing == null || itemSpacing >= 0,
            'itemSpacing must be null or positive'),
        assert(circleMargin >= 0, 'circleMargin must be positive'),
        assert(outlineRadius >= 0, 'outlineRadius must be positive'),
        assert(textPadding >= 0, 'textPadding must be positive'),
        assert(duration >= 0, 'duration must be positive');

  @override
  State<CircleNavigation> createState() => _CircleNavigationState();
}

class _CircleNavigationState extends State<CircleNavigation> {
  late int _index;

  @override
  void initState() {
    super.initState();
    // Initialize the index with the initial index provided
    _index = widget.initIndex;
  }

  @override
  void didUpdateWidget(covariant CircleNavigation oldWidget) {
    if (widget.initIndex != oldWidget.initIndex) {
      setState(() => _index = widget.initIndex);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        // Height of the navigation bar including the height provided, the circle radius and the circle margin
        height: widget.height + widget.circleWidth / 2 + widget.circleMargin,
        width: double.infinity,
        child: Stack(
          children: [
            // Background widget that handles the animated background
            Positioned.fill(
              child: Background(
                index: _index,
                total: widget.items.length,
                itemSpacing: widget.itemSpacing,
                curve: widget.curve,
                duration: widget.duration,
                circleWidth: widget.circleWidth,
                circleMargin: widget.circleMargin,
                outlineRadius: widget.outlineRadius,
                cornerRadius: widget.cornerRadius,
                navColor: widget.navColor,
                circleColor: widget.circleColor,
              ),
            ),
            // A list of NavItem with the opacity and slide animated
            ...List<Widget>.generate(
              widget.items.length,
              (index) => Positioned(
                // Calculate the horizontal position of each item
                left: context.offsetX(
                  context.percent(
                      widget.itemSpacing, index, widget.items.length),
                ),
                child: FractionalTranslation(
                  // Translation -0.5 of x offset for the center alignment
                  translation: const Offset(-0.5, 0),
                  child: NavItem(
                    item: widget.items[index],
                    textStyle: widget.textStyle,
                    textPadding: widget.textPadding,
                    // Handle item tap and update the selected index with trigger
                    onTap: index == _index
                        ? null
                        : () {
                            widget.onChange(index);
                            setState(() => _index = index);
                          },
                    selected: index == _index,
                    circleWidth: widget.circleWidth,
                    circleMargin: widget.circleMargin,
                    curve: widget.curve,
                    duration: widget.duration,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
