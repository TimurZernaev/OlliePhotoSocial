import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'package:ollie_photo_social/components/remove_offer_card.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';
import 'dart:math' as math;

import 'package:ollie_photo_social/model/user.dart';

class RemoveCouponsPage extends StatefulWidget {
  RemoveCouponsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RemoveCouponsPageState createState() => _RemoveCouponsPageState();
}

class _RemoveCouponsPageState extends State<RemoveCouponsPage> {
  List<User> couponList = userList;
  Widget _buildCouponCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
      child: RemoveOfferCard(action: removeCoupon, index: index),
    );
  }

  void removeCoupon(index) {
    setState(() {
      print('coupon removed ${index}');
      couponList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image(
              image: AssetImage('assets/images/layout/offers_topbar.png'),
              width: size.width,
              height: size.height * .2,
              /* alignment: Alignment.bottomCenter, */
              fit: BoxFit.fill),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: appPadding,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    PollingBackIcon(
                      title: 'Remove Coupons',
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                        fontSize: 42,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '',
                      style: TextStyle(color: white, fontSize: 14),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: appPadding),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: couponList.length,
                        itemBuilder: (context, index) {
                          return _buildCouponCard(context, index);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CutoutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path cutPath = Path()
      ..arcTo(Rect.fromCircle(center: Offset(0, 30), radius: 30), -math.pi / 2,
          math.pi, true)
      // ..lineTo(0, height / 2 - gapRadius)
      ..arcTo(Rect.fromCircle(center: Offset(size.width, 30), radius: 30),
          math.pi / 2, math.pi, true);

    Path path = Path.combine(PathOperation.difference,
        Path()..addRect(Rect.fromLTRB(0, 0, size.width, size.height)), cutPath);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
