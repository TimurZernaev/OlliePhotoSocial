import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_menu.dart';
import 'package:ollie_photo_social/components/choose/yes_no_detail.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';
import 'package:ollie_photo_social/model/yes_no.dart';

class PollingYesDetailPage extends StatefulWidget {
  PollingYesDetailPage({Key key, this.data}) : super(key: key);

  final YesNo data;

  @override
  _PollingYesDetailPageState createState() => _PollingYesDetailPageState();
}

class _PollingYesDetailPageState extends State<PollingYesDetailPage> {
  int selectedCategory = 0;

  Widget _buildAvatar() {
    return Container(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: yellowColor,
                          width: 3.0,
                          style: BorderStyle.solid),
                      color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: getAvatar(widget.data.user.avatar),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  if (userList[3].online)
                    Container(
                      margin: EdgeInsets.only(top: 52, left: 45),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: onlineColor,
                        shape: BoxShape.circle,
                      ),
                    )
                ],
              ),
              SizedBox(height: appPadding / 6),
              Text(
                widget.data.user.name.split(' ')[0],
                style: TextStyle(color: white, fontSize: 16),
              )
            ],
          ),
          // ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -size.height * 0.07,
            child: Container(
              width: size.width,
              height: size.height,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image(
                    image: AssetImage('assets/images/layout/home_topbar.png'),
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: appPadding * 2.5),
                    child: PollingBackIcon(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: appPadding * 1.5),
            margin: EdgeInsets.only(top: appPadding * 1.6, bottom: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildAvatar(),
                SizedBox(height: appPadding * 1.5),
                Expanded(
                  child: YesNoDetailCard(data: widget.data),
                ),
                SizedBox(height: appPadding),
              ],
            ),
          ),
          BottomNavBar(),
        ],
      ),
    );
  }
}
