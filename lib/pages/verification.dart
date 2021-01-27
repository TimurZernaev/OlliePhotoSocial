import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/block_raised_button.dart';
import 'package:ollie_photo_social/components/digital_code_field.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/pages/set_password.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  void runVerify() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SetNewPasswordPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ResponsiveScaffold(
      child: Container(
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
              'Verification',
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
              image: AssetImage("assets/images/placeholder/unlock.png"),
              height: size.height / 4,
              fit: BoxFit.cover,
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 1,
              ),
            ),
            Text(
              'Enter the verification code we\n just sent by SMS.',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'If you didn\'t receive a code. ',
                  style: TextStyle(
                    fontSize: 18,
                    color: gray3Color,
                  ),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () => {},
                  child: Text(
                    ' Resend',
                    style: TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 1,
              ),
            ),
            DigitalCodeField(digits: 4),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 1,
              ),
            ),
            BlockRaisedButton(
              label: 'Verify',
              action: runVerify,
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
