class User {
  int id;
  String avatar;
  String name;
  bool online;
  int followers;
  bool blocked;

  User({this.avatar, this.name, this.online, this.followers, this.blocked});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        avatar = json['avatar'],
        followers = json['followers'],
        online = json['online'],
        blocked = json['blocked'] == 1 ? true : false;
}
