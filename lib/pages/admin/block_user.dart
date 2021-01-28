import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/back_icon.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';
import 'package:ollie_photo_social/model/user.dart';

class BlockUserPage extends StatefulWidget {
  BlockUserPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BlockUserPageState createState() => _BlockUserPageState();
}

class _BlockUserPageState extends State<BlockUserPage> {
  List<User> users = userList;
  List<User> filteredUsers = userList;

  String followerString(int follows) {
    int kFollows = (follows / 1000).round();
    return (kFollows > 0) ? "${kFollows}k Followers" : "$follows Followers";
  }

  void blockUser(index) {
    setState(() {
      bool blk = filteredUsers[index].blocked == null
          ? false
          : filteredUsers[index].blocked;
      filteredUsers[index].blocked = !blk;
    });
  }

  Widget _buildFollower(BuildContext context, int index) {
    User user = filteredUsers[index];
    bool blocked = user.blocked == null ? false : user.blocked;

    return Container(
      margin: EdgeInsets.only(
        bottom: appPadding,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
            height: 76,
            decoration: BoxDecoration(
              color: grayColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: darkBlue.withOpacity(0.1),
                  offset: Offset(0, 5),
                  blurRadius: 5,
                )
              ],
            ),
            /* margin: EdgeInsets.only(right: 20), */
          ),
          Container(
            height: 80,
            padding: EdgeInsets.only(left: 104),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: appPadding / 4),
                      Text(
                        followerString(13008 /* user.followers */),
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonTheme(
                      minWidth: 40,
                      child: RaisedButton(
                        textColor: white,
                        color: blocked ? greenColor : redColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          /* side: BorderSide(color: Colors.red), */
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: appPadding / 2,
                            horizontal: appPadding / 2),
                        onPressed: () => blockUser(index),
                        child: Text(
                          blocked ? 'Enable' : 'Block',
                          style: TextStyle(
                              color: white,
                              /* fontWeight: FontWeight.bold, */
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(width: appPadding * 2 / 3)
                    /* ButtonTheme(
                      minWidth: 34,
                      child: RaisedButton(
                        textColor: white,
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: primaryColor),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: appPadding / 3,
                            horizontal: appPadding / 4),
                        onPressed: () {},
                        child: Text(
                          '+',
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                    ), */
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/avatar/' + user.imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchUser(text) {
    setState(() {
      filteredUsers = users
          .where((user) => user.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: appPadding,
          right: appPadding,
          top: appPadding,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: appPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackIcon(),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'All users',
                          style: TextStyle(
                            color: primaryColor,
                            // fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20 + appPadding / 2),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: appPadding * 2 / 3,
                  vertical: appPadding / 4,
                ),
                color: grayColor,
                height: 40 + appPadding / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: appPadding / 2),
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      child: TextField(
                        // controller: _controller,
                        onChanged: (text) => searchUser(text),
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: appPadding / 2,
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  return _buildFollower(context, index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
