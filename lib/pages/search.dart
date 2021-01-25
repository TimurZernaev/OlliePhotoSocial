import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/back_icon.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';
import 'package:ollie_photo_social/model/user.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<User> filteredUsers = userList;
  String followerString(int follows) {
    int kFollows = (follows / 1000).round();
    return (kFollows > 0) ? "${kFollows}k Followers" : "$follows Followers";
  }

  Widget _buildFollower(BuildContext context, int index) {
    User user = filteredUsers[index];

    return Container(
      margin: EdgeInsets.only(
        bottom: appPadding,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
            height: 70,
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
            margin: EdgeInsets.only(right: 20),
          ),
          Container(
            height: 64,
            padding: EdgeInsets.only(left: 92),
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
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: appPadding / 4),
                      Text(
                        followerString(13008 /* user.followers */),
                        style: TextStyle(color: Colors.grey.shade500),
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
                        color: redColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.red),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: appPadding / 3,
                            horizontal: appPadding / 2),
                        onPressed: () {},
                        child: Text(
                          'Block',
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    ButtonTheme(
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
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 86,
            height: 86,
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
      filteredUsers = userList
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
                          'Chalista Follower',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: appPadding / 6),
                        Text(
                          '12K FOLLOWER',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
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
