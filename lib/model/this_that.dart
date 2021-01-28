import 'package:ollie_photo_social/model/user.dart';

class ThisThat {
  String title;
  User user;
  List<String> thisImageUrls, thatImageUrls;
  String time;
  bool isGroup;

  ThisThat({
    this.thisImageUrls,
    this.thatImageUrls,
    this.title,
    this.user,
    this.time,
    this.isGroup,
  });
}
