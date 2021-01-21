import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/action_button.dart';

class StatusDialog extends StatelessWidget {
  StatusDialog({
    Key key,
    this.title,
    this.message,
    this.state,
    this.buttons,
  }) : super(key: key);
  final String title, message;
  final ActionState state;
  final List<ActionButton> buttons;

  AssetImage _getAlertIcon() {
    switch (this.state) {
      case ActionState.success:
        return AssetImage("assets/images/icon/success.png");
      case ActionState.blocked:
        return AssetImage("assets/images/icon/blocked.png");
      case ActionState.offline:
        return AssetImage("assets/images/icon/note.png");
      case ActionState.error:
      default:
        return AssetImage("assets/images/icon/wrong.png");
    }
  }

  List<Widget> _buildActionButtons() {
    List<Widget> buttonList = [];
    for (var actBtn in buttons) {
      bool filled = actBtn.filled == null || actBtn.filled;
      buttonList.add(
        SizedBox(
          height: 44,
          width: 100,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: primaryColor, width: 3.0),
            ),
            onPressed: () => actBtn.action != null ? actBtn.action : {},
            color: filled ? primaryColor : white,
            textColor: Colors.white,
            child: Text(
              actBtn.text.toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                color: filled ? white : primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    return buttonList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: appPadding),
        color: Color.fromRGBO(0, 0, 0, 0.6),
        child: Container(
          height: size.height * 2 / 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(appPadding * 2 / 3),
            color: white,
          ),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: size.height / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(appPadding * 2 / 3),
                    topRight: Radius.circular(appPadding * 2 / 3),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/layout/dialog_topbar.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: appPadding * 1.5,
                  ),
                  Image(
                    image: _getAlertIcon(),
                    width: 56,
                    height: 56,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 10,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: appPadding / 2),
                  Text(
                    message,
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 10,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _buildActionButtons(),
                  ),
                  SizedBox(
                    height: appPadding,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
