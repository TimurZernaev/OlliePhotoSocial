import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/dash_line.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';
import 'package:ollie_photo_social/components/offer_card.dart';
import 'dart:math' as math;

class OffersPage extends StatefulWidget {
  OffersPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  Widget _offerDialog(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appPadding),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: appPadding / 2,
            vertical: appPadding / 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: red,
                    ),
                  ),
                ],
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/avatar/user1.jpeg",
                    ),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(
                height: appPadding / 3,
              ),
              Text(
                'COSTA COFFEE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: appPadding / 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '10%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(
                    width: appPadding / 4,
                  ),
                  Text(
                    'off',
                    style: TextStyle(color: gray3Color),
                  ),
                ],
              ),
              SizedBox(
                height: appPadding,
              ),
              Text(
                'Purchase anything from Triple Store and get the discount.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: appPadding / 2,
                  vertical: appPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('●  This code can be use only once',
                        style: TextStyle(color: gray3Color)),
                    SizedBox(
                      height: appPadding / 3,
                    ),
                    Text('●  It is valid for 3 months from this date',
                        style: TextStyle(color: gray3Color)),
                    SizedBox(
                      height: appPadding / 3,
                    ),
                    Text('●  Can be redeemed at any store',
                        style: TextStyle(color: gray3Color)),
                  ],
                ),
              ),
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width - 40, 60),
                painter: _CutoutPainter(),
                child: DashLine(
                  dashs: 25,
                  vertical: false,
                  size: MediaQuery.of(context).size.width - appPadding * 4,
                ),
              ),
              SizedBox(
                height: appPadding,
              ),
              Container(
                width: 80,
                height: 80,
                child: Image(
                  image: AssetImage("assets/images/avatar/user1.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: appPadding / 2,
              ),
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Text('Code #Fwsj32h1238'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.copy),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: appPadding / 2,
              )
            ],
          ),
        ),
      );

  Widget _buildOfferCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _offerDialog(context);
          },
        );
      },
      child: OfferCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image(
            image: AssetImage('assets/images/layout/offers_topbar.png'),
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: appPadding,
              vertical: appPadding * 1.5,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Offers',
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '72',
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
                      'Your Point',
                      style: TextStyle(color: white, fontSize: 14),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return _buildOfferCard(context, index);
                    },
                  ),
                )
              ],
            ),
          ),
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
