import 'package:ollie_photo_social/model/user.dart';

class ThisThat {
  String title;
  User user;
  List<String> imageUrls;
  String time;
  bool isGroup;

  ThisThat({this.imageUrls, this.title, this.user, this.time, this.isGroup});
}
