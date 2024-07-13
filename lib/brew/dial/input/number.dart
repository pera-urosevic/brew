import 'dart:math';

import 'package:brew/theme/colors.dart';
import 'package:flutter/material.dart';

typedef NumberFormatter = String Function(double value);

class Number extends StatefulWidget {
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;
  final Color color;
  final double speed;
  final double incrementSmall;
  final double incrementBig;
  final double slider;
  final double width;
  final double height;
  final double fontSize;
  final NumberFormatter formatter;
  late final List<double> stops = [];
  late final List<Color> colors = [];

  Number({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
    required this.color,
    required this.formatter,
    this.speed = 1.0,
    this.incrementSmall = 0.1,
    this.incrementBig = 1.0,
    this.slider = 100,
    this.width = 100,
    this.height = 100,
    this.fontSize = 24,
  }) {
    double factor = 50.0;
    double i = 0;
    while (i < factor) {
      stops.add(i / factor);
      stops.add((i + 1) / factor);
      if (i % 2 == 0) {
        colors.add(color);
        colors.add(color);
      } else {
        colors.add(Colors.transparent);
        colors.add(Colors.transparent);
      }
      i += 1;
    }
  }

  @override
  State<Number> createState() => _NumberState();
}

class _NumberState extends State<Number> {
  double delta = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      stops: widget.stops,
                      colors: widget.colors,
                      transform: const GradientRotation(pi / 4),
                      tileMode: TileMode.repeated,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorGradientEdge,
                        colorGradientCenter,
                        colorGradientEdge,
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.formatter((widget.value + delta * widget.speed).clamp(widget.min, widget.max)),
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    shadows: [
                      Shadow(offset: const Offset(-1.5, -1.5), color: colorOutline),
                      Shadow(offset: const Offset(1.5, -1.5), color: colorOutline),
                      Shadow(offset: const Offset(1.5, 1.5), color: colorOutline),
                      Shadow(offset: const Offset(-1.5, 1.5), color: colorOutline),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onHorizontalDragStart: (details) {
        setState(() {
          delta = 0.0;
        });
      },
      onHorizontalDragUpdate: (details) {
        double? d = details.primaryDelta;
        if (d == null) return;
        setState(() {
          delta += d;
        });
      },
      onHorizontalDragEnd: (details) {
        widget.onChanged((widget.value + delta * widget.speed).clamp(widget.min, widget.max));
        setState(() {
          delta = 0.0;
        });
      },
      onTapDown: (details) {
        double tapPosition;
        double length;
        tapPosition = details.localPosition.dx;
        length = widget.width;
        if (tapPosition < length * 0.25) {
          widget.onChanged((widget.value - widget.incrementBig).clamp(widget.min, widget.max));
          return;
        }
        if (tapPosition < length * 0.5) {
          widget.onChanged((widget.value - widget.incrementSmall).clamp(widget.min, widget.max));
          return;
        }
        if (tapPosition < length * 0.75) {
          widget.onChanged((widget.value + widget.incrementSmall).clamp(widget.min, widget.max));
          return;
        }
        widget.onChanged((widget.value + widget.incrementBig).clamp(widget.min, widget.max));
      },
    );
  }
}
