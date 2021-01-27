import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_menu.dart';
import 'package:ollie_photo_social/components/user_list.dart';
import 'package:ollie_photo_social/components/home_banner.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/mock_data/yes_no_data.dart';
import 'package:ollie_photo_social/mock_data/this_that_data.dart';
import 'package:ollie_photo_social/components/choose/yes_no.dart';
import 'package:ollie_photo_social/components/choose/this_that.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategory = 0;

  void setSelectedCategory(int index) {
    setState(() {
      selectedCategory = index;
    });
  }

  List<Widget> _buildPhotoList(BuildContext context, int type, bool odd) {
    List<Widget> photoList = [];
    List list;
    switch (type) {
      case 1:
        list = thisThatList;
        break;
      case 2:
        list = thisThatList;
        // list = multiChoiceList;
        break;
      case 0:
      default:
        list = yesNoList;
    }
    for (int i = odd ? 0 : 1; i < list.length; i += 2) {
      if (type == 0)
        photoList.add(YesNoCard(data: list[i]));
      else
        photoList.add(ThisThatCard(data: list[i]));
    }

    return photoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image(
                    image: AssetImage('assets/images/layout/home_topbar.png'),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: appPadding, vertical: 20),
                    // child: Container(
                    child: Column(
                      children: [
                        HomeBanner(),
                        UserAvatarList(),
                        /* Categories(
                          setSelectedCategory: this.setSelectedCategory,
                        ), */
                      ],
                    ),
                    // ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: appPadding / 3,
                      horizontal: appPadding / 2,
                    ),
                    margin: EdgeInsets.only(bottom: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: _buildPhotoList(
                              context,
                              selectedCategory,
                              true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: _buildPhotoList(
                              context,
                              selectedCategory,
                              false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          BottomNavBar(),
        ],
      ),
    );
  }
}
