import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';
import 'package:ollie_photo_social/pages/profile.dart';
import 'package:ollie_photo_social/pages/search.dart';

class HomeBanner extends StatefulWidget {
  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  void goProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(user: userList[1]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: appPadding / 3, bottom: 0, left: appPadding, right: appPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              InkWell(
                onTap: () => goProfilePage(),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                        style: BorderStyle.solid),
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/avatar/user1.jpeg"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 22,
                  left: 22,
                ),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: primaryColor,
                  size: 10,
                ),
              ),
            ],
          ),
          Text(
            'Feed',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
