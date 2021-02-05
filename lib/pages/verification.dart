import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/block_raised_button.dart';
import 'package:ollie_photo_social/components/digital_code_field.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/module/request.dart';
import 'package:ollie_photo_social/module/storage.dart';
import 'package:ollie_photo_social/pages/on_boarding.dart';
import 'package:ollie_photo_social/pages/set_password.dart';
import 'package:ollie_photo_social/pages/signin.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({Key key, this.resetPassword}) : super(key: key);

  final bool resetPassword;

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  List<String> digits;
  String _name, _mobile;
  bool loading;

  void runVerify() async {
    if (digits.where((dg) => dg == null).toList().length > 0) {
      return print('please input all code');
    }
    setState(() {
      loading = true;
    });
    Map res = await $post(
        '/verify', {'name': _name, 'mobile': _mobile, 'code': digits.join()});
    setState(() {
      loading = false;
    });
    if (res["status"] != 200) {
      return print(res["message"]);
    }
    await AppStorage.setToken(res["data"]["token"]);
    Widget routeWidget;
    if (widget.resetPassword != null && widget.resetPassword)
      routeWidget = SetNewPasswordPage();
    else
      routeWidget = OnboardingPage();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => routeWidget,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    sendSMS();
  }

  void sendSMS() async {
    final name = await AppStorage.getUsername();
    final mobile = await AppStorage.getMoibileNumber();
    setState(() {
      _name = name;
      _mobile = mobile;
    });

    Map res = await $post('/verify-request', {'name': name, 'mobile': mobile});
    if (res["status"] != 200) {
      /* Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SigninPage(),
        ),
      ); */
      return;
    }
  }

  void chagedDigits(List dts) {
    setState(() {
      print(dts);
      digits = dts;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ResponsiveScaffold(
      child: Stack(
        children: [
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
                      onTap: () => sendSMS(),
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
                DigitalCodeField(digits: 4, chagedDigits: chagedDigits),
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
          indicator(loading),
        ],
      ),
    );
  }
}
