import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/module/storage.dart';
import 'package:ollie_photo_social/pages/profile.dart';
import 'package:ollie_photo_social/pages/search.dart';

class HomeBanner extends StatefulWidget {
  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  String avatar, name = '';

  void goProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('init home banner');
    loadMyInfo();
  }

  void loadMyInfo() async {
    var _name = await AppStorage.getUsername();
    var _avatar = await AppStorage.getAvatar();
    setState(() {
      avatar = _avatar;
      name = _name;
    });
    print('avatar $avatar');
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
                      image: getAvatar(avatar),
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
