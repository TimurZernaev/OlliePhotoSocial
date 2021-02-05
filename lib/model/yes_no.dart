import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/user.dart';

class YesNo {
  int id;
  String title;
  User user;
  List<String> images;
  String end_time;
  bool is_group;

  YesNo({this.images, this.title, this.user, this.end_time, this.is_group});
  YesNo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        user = User.fromJson(json['user']),
        images = parseToList(json['images']),
        end_time = json['end_time'],
        is_group = json['is_group'];
}
