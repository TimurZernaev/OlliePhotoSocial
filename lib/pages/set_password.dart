import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/block_raised_button.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/pages/on_boarding.dart';

class SetNewPasswordPage extends StatefulWidget {
  SetNewPasswordPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SetNewPasswordPageState createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  void runSetPassword() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ResponsiveScaffold(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage('assets/images/layout/new_password_topbar.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: appPadding * 2),
            padding: EdgeInsets.symmetric(horizontal: appPadding * 1.5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 1,
                  ),
                ),
                Text(
                  'Set New Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: white,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 1,
                  ),
                ),
                Image(
                  image: AssetImage(
                      "assets/images/placeholder/reset_password.png"),
                  height: size.height / 5,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 2,
                  ),
                ),
                Text(
                  'You can set your new password.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: appPadding,
                ),
                Text(
                  'Try more than 8 characters. ',
                  style: TextStyle(
                    fontSize: 18,
                    color: gray3Color,
                  ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 1,
                  ),
                ),
                TextFormField(
                  initialValue: '',
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(appPadding / 2),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    hoverColor: white,
                    focusColor: white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: primaryColor)),
                  ),
                  // style: TextStyle(color: black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: appPadding / 3,
                ),
                TextFormField(
                  initialValue: '',
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Re-type Password',
                    hintStyle: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(appPadding / 2),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    hoverColor: white,
                    focusColor: white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: primaryColor)),
                  ),
                  style: TextStyle(color: white),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 1,
                  ),
                ),
                BlockRaisedButton(
                  label: 'Set the Password',
                  action: runSetPassword,
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
