import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';

class PollingBackIcon extends StatelessWidget {
  final String title;
  const PollingBackIcon({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: appPadding * 1.5),
      child: Stack(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: appPadding / 4,
                    vertical: appPadding / 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    color: primaryDarkColor,
                  ),
                  child: Icon(Icons.chevron_left, color: white),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (title == null) ? '' : title,
                style: TextStyle(
                    color: white, fontWeight: FontWeight.bold, fontSize: 24),
              )
            ],
          )
        ],
      ),
    );
  }
}
