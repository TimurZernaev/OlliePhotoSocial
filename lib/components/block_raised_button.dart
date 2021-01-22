import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/elevation.dart';
import 'package:ollie_photo_social/constants.dart';

class BlockRaisedButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color color;
  final double fontSize;
  final Function action;

  BlockRaisedButton({
    Key key,
    @required this.label,
    this.action,
    this.textColor,
    this.color,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = this.color == null ? primaryColor : this.color;
    var textColor = this.textColor == null ? white : this.textColor;
    var fontSize = this.fontSize == null ? 18.0 : this.fontSize;

    return SizedBox(
      width: double.infinity,
      child: ButtonTheme(
        child: CustomElevation(
          child: RaisedButton(
            textColor: textColor,
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appPadding / 3),
              side: BorderSide(
                color: color,
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: appPadding * 2 / 3,
              horizontal: appPadding / 2,
            ),
            onPressed: () => action == null ? {} : action(),
            child: Text(
              this.label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
