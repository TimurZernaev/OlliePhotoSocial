import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/block_raised_button.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/pages/admin/add_coupon.dart';
import 'package:ollie_photo_social/pages/admin/block_user.dart';
import 'package:ollie_photo_social/pages/admin/gamification.dart';
import 'package:ollie_photo_social/pages/admin/remove_coupon.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool pressedAddCp = false,
      pressedRmCp = false,
      pressedBlUser = false,
      pressedGame = false;

  void goGamification() {
    setState(() {
      pressedGame = true;
    });
    goAdminSettingPage(GamificationPage());
  }

  void goAddCoupon() {
    setState(() {
      pressedAddCp = true;
    });
    goAdminSettingPage(AddCouponPage());
  }

  void goRemoveCoupon() {
    setState(() {
      pressedRmCp = true;
    });
    goAdminSettingPage(RemoveCouponsPage());
  }

  void goBlockUser() {
    setState(() {
      pressedBlUser = true;
    });
    goAdminSettingPage(BlockUserPage());
  }

  void goAdminSettingPage(Widget routeWidget) {
    Future.delayed(Duration(milliseconds: 10), () {
      setState(() {
        pressedGame = false;
        pressedAddCp = false;
        pressedRmCp = false;
        pressedBlUser = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => routeWidget,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Image(
              image: AssetImage('assets/images/layout/new_polling_topbar.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.all(appPadding * 2),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Main Menu',
                  style: TextStyle(
                    color: white,
                    fontSize: 22,
                  ),
                ),
                Expanded(
                  child: SizedBox(height: appPadding),
                ),
                BlockRaisedButton(
                    label: 'Gamification',
                    color: pressedGame ? yellowColor : Colors.transparent,
                    textColor: pressedGame ? primaryColor : yellowColor,
                    borderColor: pressedGame ? null : yellowColor,
                    action: goGamification),
                SizedBox(height: appPadding),
                BlockRaisedButton(
                    label: 'Add Coupon',
                    color: pressedAddCp ? yellowColor : Colors.transparent,
                    textColor: pressedAddCp ? primaryColor : yellowColor,
                    borderColor: pressedAddCp ? null : yellowColor,
                    action: goAddCoupon),
                SizedBox(height: appPadding),
                BlockRaisedButton(
                    label: 'Remove Coupon',
                    color: pressedRmCp ? yellowColor : Colors.transparent,
                    textColor: pressedRmCp ? primaryColor : yellowColor,
                    borderColor: pressedRmCp ? null : yellowColor,
                    action: goRemoveCoupon),
                SizedBox(height: appPadding),
                BlockRaisedButton(
                    label: 'Block User',
                    color: pressedBlUser ? yellowColor : Colors.transparent,
                    textColor: pressedBlUser ? primaryColor : yellowColor,
                    borderColor: pressedBlUser ? null : yellowColor,
                    action: goBlockUser),
                Expanded(
                  child: SizedBox(height: appPadding),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
