import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';

class DigitalCodeField extends StatefulWidget {
  DigitalCodeField({Key key, this.digits}) : super(key: key);
  final int digits;

  _DigitalCodeFieldState createState() => _DigitalCodeFieldState();
}

class _DigitalCodeFieldState extends State<DigitalCodeField> {
  int focused = 0;
  List<FocusNode> _focusNodes = []; //List.generate(4, (index) => FocusNode());

  List<Widget> _buildDCWidget() {
    List<Widget> dcWidget = [];
    for (var idx = 0; idx < widget.digits; idx++) {
      dcWidget.add(
        Container(
          width: appPadding * 2,
          margin: EdgeInsets.symmetric(
            horizontal: appPadding / 4,
          ),
          padding: EdgeInsets.only(
            bottom: appPadding / 2,
            left: appPadding / 2,
            right: appPadding / 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(appPadding / 2),
            border: Border.all(
                color: (focused == idx) ? primaryColor : Color(0xff888888),
                width: 1.5),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            focusNode: _focusNodes[idx],
            maxLength: 1,
            decoration: InputDecoration(
              hintText: '',
              counterText: '',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff666666), width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
            ),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      );
    }
    return dcWidget;
  }

  @override
  void initState() {
    for (var idx = 0; idx < widget.digits; idx++) {
      _focusNodes.add(FocusNode());
      _focusNodes[idx].addListener(() {
        if (_focusNodes[idx].hasFocus) {
          setState(() {
            focused = idx;
          });
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _focusNodes.forEach((el) => el.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildDCWidget(),
    );
  }
}
