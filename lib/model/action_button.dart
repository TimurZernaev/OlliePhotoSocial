class ActionButton {
  String text;
  bool filled;
  void Function() action;

  ActionButton({this.text, this.action, this.filled});
}

enum ActionState {
  success,
  error,
  blocked,
  offline,
}
