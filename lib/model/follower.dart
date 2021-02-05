import 'package:ollie_photo_social/model/user.dart';

class Follower {
  User user;
  int blocked;
  bool is_friend;

  Follower({this.user, this.blocked, this.is_friend});

  Follower.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['follower']),
        blocked = json['blocked'],
        is_friend = json['is_friend'];
}
