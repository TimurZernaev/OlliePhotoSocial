import 'package:flutter/material.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.chevron_left, size: 36),
    );
  }
}
