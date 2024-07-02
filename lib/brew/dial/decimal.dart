import 'package:brew/size.dart';
import 'package:brew/brew/dial/input/number.dart';
import 'package:flutter/material.dart';

class DialDecimal extends StatelessWidget {
  final String name;
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final double speed;
  final int decimals;
  final Color color;
  final double increment;

  const DialDecimal({
    super.key,
    required this.name,
    required this.value,
    required this.onChanged,
    required this.color,
    this.min = 1.0,
    this.max = 1000.0,
    this.speed = 0.07,
    this.decimals = 1,
    this.increment = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: relativeSize.height(0.035)),
        ),
        const SizedBox(
          height: 10,
        ),
        Number(
          axis: Axis.horizontal,
          min: min,
          max: max,
          value: value,
          onChanged: onChanged,
          color: color,
          width: relativeSize.width(0.9),
          height: relativeSize.height(0.1),
          fontSize: relativeSize.height(0.05),
        ),
      ],
    );
  }
}
