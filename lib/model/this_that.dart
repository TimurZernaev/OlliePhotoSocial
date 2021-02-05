import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/user.dart';

class ThisThat {
  int id;
  String title;
  User user;
  List<String> this_images, that_images;
  String end_time;
  bool is_group;

  ThisThat({
    this.this_images,
    this.that_images,
    this.title,
    this.user,
    this.end_time,
    this.is_group,
  });

  ThisThat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        user = User.fromJson(json['user']),
        this_images = parseToList(json['this_images']),
        that_images = parseToList(json['that_images']),
        end_time = json['end_time'],
        is_group = json['is_group'];
}
