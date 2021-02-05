import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/friend.dart';
import 'package:ollie_photo_social/module/request.dart';
import 'package:ollie_photo_social/pages/user_detail.dart';

class UserAvatarList extends StatefulWidget {
  @override
  _UserAvatarListState createState() => _UserAvatarListState();
}

class _UserAvatarListState extends State<UserAvatarList> {
  List<Friend> friendList = [];

  @override
  void initState() {
    super.initState();
    getFriendsList();
  }

  void getFriendsList() async {
    Map res = await $get('/setting/friends', true);
    print(res);
    setState(() {
      friendList = List<Friend>.from(
        res['friends'].map((model) => Friend.fromJson(model)),
      );
    });
  }

  Widget _buildUserAvatar(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => goUserDetailPage(context, friendList[index].user),
      child: Container(
        padding: EdgeInsets.only(left: appPadding / 4),
        margin: EdgeInsets.only(top: index % 2 == 0 ? 30 : 0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: appPadding / 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white,
                            width: 3.0,
                            style: BorderStyle.solid),
                        color: Colors.black,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: getAvatar(friendList[index].user.avatar),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                    if (friendList[index].user.online != null &&
                        friendList[index].user.online)
                      Container(
                        margin: EdgeInsets.only(top: 50, left: 48),
                        height: 9,
                        width: 9,
                        decoration: BoxDecoration(
                          color: onlineColor,
                          shape: BoxShape.circle,
                        ),
                      )
                  ],
                ),
                SizedBox(height: appPadding / 6),
                Text(
                  friendList[index].user.name.split(' ')[0],
                  style: TextStyle(color: white),
                )
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: appPadding / 3),
      height: 120,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: friendList.length,
        itemBuilder: (context, index) {
          return _buildUserAvatar(context, index);
        },
      ),
    );
  }
}
