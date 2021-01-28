import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/action_button.dart';

class DialogBox {
  static Dialog createSuccess(
      BuildContext context, String message, Function action) {
    return create(
      context,
      ActionState.success,
      'Thank You!',
      message == null ? 'Your polling has been sent.' : message,
      [
        ActionButton(
          text: 'ok',
          action: () {
            Navigator.of(context).pop();
            action();
          },
        ),
      ],
    );
  }

  static Dialog createError(BuildContext context) {
    return create(
      context,
      ActionState.error,
      'Something went wrong!',
      'Failed to post.',
      [
        ActionButton(text: 'No', filled: false),
        ActionButton(
          text: 'try again',
          action: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  static Dialog createBlocked(BuildContext context) {
    return create(
      context,
      ActionState.blocked,
      'Block User',
      'Do you want to block this user',
      [
        ActionButton(text: 'No', filled: false),
        ActionButton(
          text: 'yes',
          action: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  static Dialog createOffline(BuildContext context) {
    return create(
      context,
      ActionState.offline,
      'Not Connected',
      'Please check your connection.',
      [
        ActionButton(
          text: 'retry',
          action: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  static Dialog create(
    BuildContext context,
    ActionState state,
    String title,
    String message,
    List<ActionButton> buttons,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(appPadding / 2),
      ),
      elevation: 2,
      backgroundColor: Colors.transparent,
      child: contentBox(context, state, title, message, buttons),
    );
  }

  static Widget contentBox(BuildContext context, ActionState state,
      String title, String message, List<ActionButton> buttons) {
    Size size = MediaQuery.of(context).size;

    return Container(
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
                image: _getAlertIcon(state),
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
                children: _buildActionButtons(context, buttons),
              ),
              SizedBox(
                height: appPadding,
              )
            ],
          )
        ],
      ),
    );
  }

  static AssetImage _getAlertIcon(ActionState state) {
    switch (state) {
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

  static List<Widget> _buildActionButtons(
      BuildContext context, List<ActionButton> buttons) {
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
            onPressed: () => actBtn.action != null ? actBtn.action() : {},
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
}
