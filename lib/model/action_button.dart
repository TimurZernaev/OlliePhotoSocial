import 'package:flutter/material.dart';

class ActionButton {
  String text;
  bool filled;
  Function() action;

  ActionButton({this.text, this.action, this.filled});
}

enum ActionState {
  success,
  error,
  blocked,
  offline,
}
