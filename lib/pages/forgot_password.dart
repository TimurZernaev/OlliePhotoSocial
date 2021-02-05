import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/block_raised_button.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/module/storage.dart';
import 'package:ollie_photo_social/pages/verification.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String name, mobile;
  TextEditingController mobileController = TextEditingController();

  void runForgotAction() async {
    await AppStorage.setMoibileNumber(mobileController.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationPage(resetPassword: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
              'Forgot Password?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: black,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 1,
              ),
            ),
            Image(
              image: AssetImage("assets/images/placeholder/security.png"),
              height: size.height / 5,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: appPadding / 2,
            ),
            Text(
              'Enter your phone number\n associated with your account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: black,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 1,
              ),
            ),
            Text(
              'We will send a verification code \n to reset your password.',
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
              initialValue: mobile,
              controller: mobileController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter mobile number',
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 1,
              ),
            ),
            BlockRaisedButton(
              label: 'Send SMS',
              action: runForgotAction,
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
