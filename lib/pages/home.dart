import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ollie_photo_social/components/bottom_menu.dart';
import 'package:ollie_photo_social/components/choose/multi_choice.dart';
import 'package:ollie_photo_social/components/user_list.dart';
import 'package:ollie_photo_social/components/categories.dart';
import 'package:ollie_photo_social/components/home_banner.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/mock_data/multi_data.dart';
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

  Widget _buildPollItem(int index) {
    int yesLastIdx = yesNoList.length - 1;
    if (index <= yesLastIdx)
      return YesNoCard(
        data: yesNoList[index],
      );
    else
      return ThisThatCard(
        data: thisThatList[index - yesLastIdx - 1],
      );
  }

  Widget _buildMultiItem(int index) {
    return MultiChoiceCard(data: multiList[index]);
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
                    padding: EdgeInsets.symmetric(vertical: appPadding),
                    child: Column(
                      children: [
                        HomeBanner(),
                        UserAvatarList(),
                        /* Categories(
                          setSelectedCategory: this.setSelectedCategory,
                        ), */
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: appPadding / 3),
                  margin: EdgeInsets.only(bottom: appPadding / 2),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: StaggeredGridView.countBuilder(
                      primary: false,
                      crossAxisCount: 4,
                      mainAxisSpacing: appPadding / 3,
                      crossAxisSpacing: appPadding / 6,
                      itemCount: yesNoList.length + thisThatList.length,
                      itemBuilder: (context, index) => _buildPollItem(index),
                      staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: multiList.length,
                    itemBuilder: (context, index) {
                      return _buildMultiItem(index);
                    },
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
