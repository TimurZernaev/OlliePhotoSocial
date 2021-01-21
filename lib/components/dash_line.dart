import 'package:flutter/material.dart';

class DashLine extends StatelessWidget {
  final double size;
  final Color color;
  final bool vertical;
  final int dashs;

  const DashLine({
    this.size,
    this.color = Colors.black,
    this.dashs = 10,
    this.vertical = true,
  });

  @override
  Widget build(BuildContext context) {
    final dashStroke = 0.3;
    final dashSize = size / (1.3 * dashs);
    if (vertical)
      return Column(
        children: List.generate(dashs, (_) {
          return SizedBox(
            width: dashStroke,
            height: dashSize,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color),
            ),
          );
        }),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
      );
    else
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(dashs, (_) {
          return SizedBox(
            width: dashSize,
            height: dashStroke,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color),
            ),
          );
        }),
      );
  }
}
