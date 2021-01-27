import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/block_raised_button.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/components/rounded_raised_button.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/pages/home.dart';
import 'package:ollie_photo_social/pages/signup.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int step = 0;

  Widget _buildInterestStep(Size size) {
    List interests = [
      ["Women Bags", 0.05, 0.05, .9],
      ["Hats", .4, .06, .45],
      ["Electronics", .65, .05, .72],
      ["Watches", .32, .23, 1.0],
      ["Cars", .72, .28, .5],
      ["Wallets", 0.06, .33, .72],
      ["Comics", .42, .5, .55],
      ["Jewellery", .63, .42, 1.0],
    ];
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: List.generate(
                interests.length,
                (index) => _buildCategoryItem(interests[index], size),
              ),
            ),
          ),
          SizedBox(height: appPadding * 2),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(List interest, Size size) {
    return Positioned(
      left: size.width * interest[1],
      top: size.height * .83 * interest[2],
      child: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () => print('${interest[0]}'),
              child: Image(
                image: AssetImage(
                    "assets/images/icon/${interest[0].toString().toLowerCase()}.png"),
                width: 150 * interest[3],
                height: 150 * interest[3] * .9,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topLeft,
              ),
            ),
            Text(
              interest[0],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  void nextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
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
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage('assets/images/layout/onboarding_topbar.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: appPadding * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: appPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Explore',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32),
                      ),
                    ],
                  ),
                ),
                _buildInterestStep(size),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: appPadding),
                  margin: EdgeInsets.only(bottom: appPadding),
                  child: Row(
                    children: [
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          BottomNextIcon(
            primary: true,
            nextAction: nextPage,
          ),
        ],
      ),
    );
  }
}
