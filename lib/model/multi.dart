import 'package:ollie_photo_social/model/user.dart';

class MultiChoice {
  String title;
  User user;
  List<String> choices;

  MultiChoice({
    this.title,
    this.user,
    this.choices,
  });
}
