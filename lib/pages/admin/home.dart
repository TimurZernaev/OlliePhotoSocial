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
  void goGamification() {
    goAdminSettingPage(GamificationPage());
  }

  void goAddCoupon() {
    goAdminSettingPage(AddCouponPage());
  }

  void goRemoveCoupon() {
    goAdminSettingPage(RemoveCouponsPage());
  }

  void goBlockUser() {
    goAdminSettingPage(BlockUserPage());
  }

  void goAdminSettingPage(Widget routeWidget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeWidget,
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
                SizedBox(height: appPadding),
                BlockRaisedButton(
                    label: 'Gamification',
                    color: yellowColor,
                    textColor: primaryColor,
                    action: goGamification),
                SizedBox(height: appPadding),
                BlockRaisedButton(
                    label: 'Add Coupon',
                    color: Colors.transparent,
                    textColor: yellowColor,
                    borderColor: yellowColor,
                    action: goAddCoupon),
                SizedBox(height: appPadding),
                BlockRaisedButton(
                    label: 'Remove Coupon',
                    color: Colors.transparent,
                    textColor: yellowColor,
                    borderColor: yellowColor,
                    action: goRemoveCoupon),
                SizedBox(height: appPadding),
                BlockRaisedButton(
                    label: 'Block User',
                    color: Colors.transparent,
                    textColor: yellowColor,
                    borderColor: yellowColor,
                    action: goBlockUser),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
