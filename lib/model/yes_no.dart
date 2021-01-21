import 'package:ollie_photo_social/model/user.dart';

class YesNo {
  String title;
  User user;
  String imageUrl;
  String time;
  bool isGroup;

  YesNo({this.imageUrl, this.title, this.user, this.time, this.isGroup});
}
