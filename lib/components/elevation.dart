import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';

class CustomElevation extends StatelessWidget {
  final Widget child;

  CustomElevation({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 46,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: this.child,
    );
  }
}
