import 'package:flutter/material.dart';
import 'painter.dart';
import '../utils.dart';

class Background extends StatefulWidget {
  /// Current index of the item
  final int index;

  /// Total number of items
  final int total;

  /// Trim value for start and end of the navigation bar
  final double? trim;

  /// Animation curve
  final Curve curve;

  /// Duration of the animation in milliseconds
  final int duration;

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

  const Background({
    super.key,
    required this.index,
    required this.total,
    this.trim,
    required this.curve,
    required this.duration,
    required this.circleWidth,
    required this.circleMargin,
    required this.outlineRadius,
    required this.cornerRadius,
    required this.navColor,
    required this.circleColor,
  });

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  // Calculate the animation percent value based on itemSpacing, current index and total items
  double get _value => context.percent(widget.trim, widget.index, widget.total);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    // Set the initial value of the animation controller after the first frame
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _animationController.value = _value);
  }

  @override
  void didUpdateWidget(covariant Background oldWidget) {
    // If the index changes, stop the current animation and animate to the new value
    if (widget.index != oldWidget.index) {
      _animationController.stop();
      _animationController.animateTo(_value, curve: widget.curve);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is removed from the tree
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: widget.circleWidth / 2),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) => CustomPaint(
            painter: Painter(
              circleWidth: widget.circleWidth,
              circleMargin: widget.circleMargin,
              outlineRadius: widget.outlineRadius,
              cornerRadius: widget.cornerRadius,
              circleX: context.offsetX(_animationController.value),
              navColor: widget.navColor,
              circleColor: widget.circleColor,
            ),
          ),
        ),
      );
}
