import 'package:brew/size.dart';
import 'package:brew/brew/dial/input/number.dart';
import 'package:flutter/material.dart';

class DialNumeric extends StatelessWidget {
  final String name;
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final double speed;
  final Color color;
  final double incrementSmall;
  final double incrementBig;
  final NumberFormatter? formatter;

  const DialNumeric({
    super.key,
    required this.name,
    required this.value,
    required this.onChanged,
    required this.color,
    this.min = 1.0,
    this.max = 1000.0,
    this.speed = 1.0,
    this.incrementSmall = 0.1,
    this.incrementBig = 1.0,
    this.formatter,
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
          min: min,
          max: max,
          value: value,
          speed: speed,
          incrementSmall: incrementSmall,
          incrementBig: incrementBig,
          onChanged: onChanged,
          color: color,
          width: relativeSize.width(0.9),
          height: relativeSize.height(0.1),
          fontSize: relativeSize.height(0.05),
          formatter: formatter ?? (value) => value.toStringAsFixed(1),
        ),
      ],
    );
  }
}
