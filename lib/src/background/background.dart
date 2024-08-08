import 'package:flutter/material.dart';
import 'painter.dart';
import '../utils.dart';

class Background extends StatefulWidget {
  final int index;
  final int total;
  final double? itemSpacing;
  final Curve curve;
  final int duration;
  final double circleWidth;
  final double circleMargin;
  final double outlineRadius;
  final BorderRadius cornerRadius;
  final Color navColor;
  final Color circleColor;

  const Background({
    super.key,
    required this.index,
    required this.total,
    this.itemSpacing,
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

  double get _value =>
      context.percent(widget.itemSpacing, widget.index, widget.total);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _animationController.value = _value);
  }

  @override
  void didUpdateWidget(covariant Background oldWidget) {
    if (widget.index != oldWidget.index) {
      _animationController.stop();
      _animationController.animateTo(_value, curve: widget.curve);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
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
