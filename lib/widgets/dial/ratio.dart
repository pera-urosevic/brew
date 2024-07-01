import 'package:brew/helpers/size.dart';
import 'package:brew/widgets/dial/number/number.dart';
import 'package:flutter/material.dart';

class DialRatio extends StatelessWidget {
  final String name;
  final int value1;
  final int value2;
  final ValueChanged<int> onChanged1;
  final ValueChanged<int> onChanged2;
  final Color color1;
  final Color color2;
  final int min;
  final int max;
  final int step;
  final int increment;

  const DialRatio({
    super.key,
    required this.name,
    required this.value1,
    required this.value2,
    required this.onChanged1,
    required this.onChanged2,
    required this.color1,
    required this.color2,
    this.min = 1,
    this.max = 20,
    this.step = 1,
    this.increment = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(fontSize: relativeSize.height(0.035)),
        ),
        const SizedBox(
          width: double.infinity,
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Number(
              axis: Axis.vertical,
              min: 1,
              max: 20,
              decimals: 0,
              increment: 1,
              value: value1.toDouble(),
              onChanged: (value) => onChanged1(value.toInt()),
              width: relativeSize.width(0.25),
              height: relativeSize.height(0.25),
              color: color1,
              fontSize: relativeSize.height(0.06),
            ),
            const Spacer(),
            Number(
              axis: Axis.vertical,
              min: 1,
              max: 20,
              decimals: 0,
              increment: 1,
              value: value2.toDouble(),
              onChanged: (value) => onChanged2(value.toInt()),
              width: relativeSize.width(0.25),
              height: relativeSize.height(0.25),
              color: color2,
              fontSize: relativeSize.height(0.06),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
