import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/block_raised_button.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/pages/home.dart';
import 'package:ollie_photo_social/pages/signup.dart';

import 'forgot_password.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  void goSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupPage(),
      ),
    );
  }

  void goForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordPage(),
      ),
    );
  }

  void runSignin() {
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
    return ResponsiveScaffold(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Image(
              image: AssetImage('assets/images/layout/sign_topbar.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: appPadding * 2),
            padding: EdgeInsets.symmetric(horizontal: appPadding * 1.5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 1,
                  ),
                ),
                Image(
                  image: AssetImage("assets/images/layout/logo.png"),
                  height: size.height / 4,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: SizedBox(
                    height: 1,
                  ),
                ),
                Text(
                  'Welcom back,',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: white,
                  ),
                ),
                SizedBox(
                  height: appPadding / 3,
                ),
                Text(
                  'Sign in to continue',
                  style: TextStyle(
                    color: white,
                  ),
                ),
                SizedBox(
                  height: appPadding,
                ),
                TextFormField(
                  initialValue: '',
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: white, fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(appPadding / 2),
                      borderSide: BorderSide(color: white),
                    ),
                    hoverColor: white,
                    focusColor: white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: white)),
                    suffixIcon: Icon(
                      Icons.check_circle_outline_rounded,
                      color: white,
                    ),
                  ),
                  style: TextStyle(color: white),
                ),
                SizedBox(
                  height: appPadding * 2 / 3,
                ),
                TextFormField(
                  initialValue: '',
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: white, fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(appPadding / 2),
                      borderSide: BorderSide(color: white),
                    ),
                    hoverColor: white,
                    focusColor: white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: white)),
                    suffixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: white,
                    ),
                  ),
                  style: TextStyle(color: white),
                ),
                SizedBox(
                  height: appPadding / 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () => goForgotPassword(),
                      child: Text(
                        'forgot password',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: appPadding / 2,
                ),
                BlockRaisedButton(
                  label: 'Sign in',
                  color: white,
                  textColor: primaryColor,
                  action: runSignin,
                ),
                SizedBox(
                  height: appPadding / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(color: white, fontSize: 16),
                    ),
                    InkWell(
                      onTap: () => goSignUp(),
                      child: Text(
                        'Register ',
                        style: TextStyle(color: yellowColor, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: appPadding * 2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
