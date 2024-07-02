import 'package:flutter/material.dart';

class Number extends StatefulWidget {
  final Axis axis;
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;
  final Color color;
  final int decimals;
  final double increment;
  final double slider;
  final double width;
  final double height;
  final double fontSize;

  const Number({
    super.key,
    required this.axis,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
    required this.color,
    this.decimals = 1,
    this.increment = 0.1,
    this.slider = 100,
    this.width = 100,
    this.height = 100,
    this.fontSize = 24,
  });

  @override
  State<Number> createState() => _NumberState();
}

class _NumberState extends State<Number> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: widget.color,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/stripes.png',
                    repeat: ImageRepeat.repeat,
                    alignment: Alignment(widget.value.toDouble(), 0),
                  ),
                ),
                Center(
                  child: Text(
                    widget.value.toStringAsFixed(widget.decimals),
                    style: TextStyle(fontSize: widget.fontSize),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onHorizontalDragUpdate: (details) {
        if (widget.axis == Axis.horizontal) {
          double? delta = details.primaryDelta;
          if (delta == null) return;
          widget.onChanged((widget.value + delta).clamp(widget.min, widget.max));
        }
      },
      onVerticalDragUpdate: (details) {
        if (widget.axis == Axis.vertical) {
          double? delta = details.primaryDelta;
          if (delta == null) return;
          widget.onChanged((widget.value + delta).clamp(widget.min, widget.max));
        }
      },
      onTapDown: (details) {
        double tapPosition;
        double length;
        if (widget.axis == Axis.horizontal) {
          tapPosition = details.localPosition.dx;
          length = widget.width;
        } else {
          tapPosition = details.localPosition.dy;
          length = widget.height;
        }
        if (tapPosition > length / 2) {
          widget.onChanged((widget.value + widget.increment).clamp(widget.min, widget.max));
        } else {
          widget.onChanged((widget.value - widget.increment).clamp(widget.min, widget.max));
        }
      },
    );
  }
}
