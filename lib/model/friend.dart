import 'package:ollie_photo_social/model/user.dart';

class Friend {
  User user;

  Friend({this.user});

  Friend.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['friend']);
}
