import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/block_raised_button.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/components/rounded_raised_button.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/pages/home.dart';
import 'package:ollie_photo_social/pages/signup.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int step = 0;

  List<Widget> _buildStepIcon() {
    List<Widget> stepIcon = [];
    for (var idx = 0; idx < 4; idx++) {
      stepIcon.add(
        SizedBox(
          width: 12,
          child: Icon(
            Icons.circle,
            size: 8,
            color: step == idx ? primaryColor : primaryTrans2Color,
          ),
        ),
      );
    }
    return stepIcon;
  }

  Widget _buildInterestStep() {
    return Container();
  }

  Widget _buildStepContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const stepImages = [
      'access_camera',
      'access_camera',
      'push_notification',
      'choose_language'
    ];
    List<List<Widget>> skipAndNexts = [
      [],
      [
        RoundedRaisedButton(label: 'Allow Camera'),
      ],
      [
        RoundedRaisedButton(label: 'Allow Notification'),
      ],
      [
        RoundedRaisedButton(label: 'Arabic', filled: false),
        SizedBox(width: appPadding / 2),
        RoundedRaisedButton(label: 'English'),
      ],
    ];
    var stepTitles = [
      ['Choose', 'Your Interest'],
      ['Access', 'Your Camera'],
      ['Get Push', 'Notifications'],
      ['Choose', 'Your Language']
    ];
    if (step == 0) return _buildInterestStep();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(height: 1),
          ),
          Image(
            image:
                AssetImage("assets/images/placeholder/${stepImages[step]}.png"),
            width: size.width * 0.75,
            height: size.width * 0.7,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: skipAndNexts[step],
          ),
          SizedBox(height: appPadding / 2),
          (step == 1 || step == 2)
              ? InkWell(
                  onTap: () => skipAndNext(),
                  child: Text(
                    'Not Now',
                    style: TextStyle(
                      color: Color(0xff555555),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              : SizedBox(
                  width: 1,
                ),
          Expanded(
            flex: 2,
            child: SizedBox(height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                stepTitles[step][0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: appPadding / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                stepTitles[step][1],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: SizedBox(height: 1),
          ),
        ],
      ),
    );
  }

  void skipAndNext() {
    if (step == 3) return nextPage();

    setState(() {
      step += 1;
    });
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
            margin: EdgeInsets.symmetric(vertical: appPadding * 2),
            padding: EdgeInsets.symmetric(horizontal: appPadding * 1.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Image(
                          image:
                              AssetImage("assets/images/icon/ollie_marker.png"),
                          width: 28,
                          height: 28,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Ollie',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => {},
                      child: Text(
                        'SKIP',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                _buildStepContent(context),
                Row(
                  children: _buildStepIcon(),
                )
              ],
            ),
          ),
          BottomNextIcon(
            primary: true,
            nextAction: skipAndNext,
          ),
        ],
      ),
    );
  }
}
