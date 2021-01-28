import 'package:ollie_photo_social/model/user.dart';

class YesNo {
  String title;
  User user;
  List<String> imageUrls;
  String time;
  bool isGroup;

  YesNo({this.imageUrls, this.title, this.user, this.time, this.isGroup});
}
