import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/user.dart';

class MultiChoice {
  int id;
  String title;
  User user;
  List<String> choices;

  MultiChoice({
    this.title,
    this.user,
    this.choices,
  });

  MultiChoice.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        user = User.fromJson(json['user']),
        choices = parseToList(json['options']);
}
