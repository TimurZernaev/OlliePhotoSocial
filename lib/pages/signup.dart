import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/block_raised_button.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/module/request.dart';
import 'package:ollie_photo_social/module/storage.dart';
import 'package:ollie_photo_social/pages/signin.dart';
import 'package:ollie_photo_social/pages/verification.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool _nameInvalid = false, _passwordInvalid = false, _mobileInvalid = false;
  final _nameErrMsg = 'Username is required.';
  final _pwdErrMsg = 'Password is required.';
  final _mobileErrMsg = 'Mobile number is required';
  bool loading;

  void goSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SigninPage(),
      ),
    );
  }

  void runSignup() async {
    String username = usernameController.text;
    String password = passwordController.text;
    String mobile = mobileController.text;

    if (username == null ||
        username.isEmpty ||
        password == null ||
        password.isEmpty ||
        mobile == null ||
        mobile.isEmpty)
      return setState(() {
        if (username == null || username.isEmpty) _nameInvalid = true;
        if (password == null || password.isEmpty) _passwordInvalid = true;
        if (mobile == null || mobile.isEmpty) _mobileInvalid = true;
      });
    setState(() {
      loading = true;
    });
    Map res = await $post('/signup', {
      'name': username,
      'password': password,
      'mobile': mobile,
    });
    setState(() {
      loading = false;
    });
    if (res['status'] == 200) {
      await AppStorage.setMoibileNumber(mobile);
      await AppStorage.setUsername(username);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationPage(),
        ),
      );
    } else {
      print(res["message"]);
    }
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
                  'Register to start',
                  style: TextStyle(
                    color: white,
                  ),
                ),
                SizedBox(
                  height: appPadding,
                ),
                TextFormField(
                  controller: usernameController,
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
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: white)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: white)),
                    suffixIcon: Icon(
                      Icons.check_circle_outline_rounded,
                      color: white,
                    ),
                    errorText: _nameInvalid ? _nameErrMsg : null,
                  ),
                  style: TextStyle(color: white),
                ),
                SizedBox(
                  height: appPadding * 2 / 3,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
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
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: white)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: white)),
                    suffixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: white,
                    ),
                    errorText: _passwordInvalid ? _pwdErrMsg : null,
                  ),
                  style: TextStyle(color: white),
                ),
                SizedBox(
                  height: appPadding * 2 / 3,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: mobileController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
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
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: white)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: white)),
                    suffixIcon: Icon(
                      Icons.check_circle_outline_rounded,
                      color: white,
                    ),
                    errorText: _mobileInvalid ? _mobileErrMsg : null,
                  ),
                  style: TextStyle(color: white),
                ),
                SizedBox(
                  height: appPadding,
                ),
                BlockRaisedButton(
                  label: 'Sign up',
                  color: white,
                  textColor: primaryColor,
                  action: runSignup,
                ),
                SizedBox(
                  height: appPadding / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Have an account? ',
                      style: TextStyle(color: white, fontSize: 16),
                    ),
                    InkWell(
                      onTap: () => goSignIn(),
                      child: Text(
                        'Sign in ',
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
          indicator(loading),
        ],
      ),
    );
  }
}
