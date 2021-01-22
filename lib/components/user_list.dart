import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';
import 'package:ollie_photo_social/pages/user_detail.dart';

class UserAvatarList extends StatefulWidget {
  @override
  _UserAvatarListState createState() => _UserAvatarListState();
}

class _UserAvatarListState extends State<UserAvatarList> {
  int selectedCategoryIndex = 0;

  Widget _buildUserAvatar(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryIndex = index;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailPage(user: userList[index]),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: appPadding / 4),
        margin: EdgeInsets.only(top: index % 2 == 0 ? 40 : 0),
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
                          image: AssetImage(
                            "assets/images/avatar/" + userList[index].imageUrl,
                          ),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                    if (userList[index].online)
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
                  userList[index].name.split(' ')[0],
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
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return _buildUserAvatar(context, index);
        },
      ),
    );
  }
}
