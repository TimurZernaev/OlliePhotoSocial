import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ollie_photo_social/pages/user_detail.dart';

import 'model/user.dart';

//colors used in this app

const Color white = Colors.white;
const Color black = Colors.black;
const Color red = Colors.red;
const Color greenColor = Color.fromRGBO(91, 182, 119, 1.0);
const Color darkBlue = Color.fromRGBO(19, 26, 44, 1.0);
const Color orange = Color.fromRGBO(255, 206, 101, 1.0);
const Color onlineColor = Color.fromRGBO(0, 236, 202, 1.0);
const Color primaryGrdStartColor = Color.fromRGBO(110, 58, 134, 0);
const Color primaryGrdStopColor = Color.fromRGBO(110, 58, 134, 1);
const Color primaryColor = Color.fromRGBO(121, 77, 141, 1.0);
const Color primaryDarkColor = Color.fromRGBO(90, 57, 105, 1.0);
const Color primaryTransColor = Color.fromRGBO(121, 77, 141, .8);
const Color primaryTrans2Color = Color.fromRGBO(121, 77, 141, .3);
const Color grayColor = Color.fromRGBO(239, 239, 239, 1.0);
const Color gray2Color = Color.fromRGBO(228, 228, 228, 1.0);
const Color gray3Color = Color.fromRGBO(144, 144, 144, 1.0);
const Color redColor = Color.fromRGBO(223, 96, 114, 1.0);
const Color yellowColor = Color.fromRGBO(255, 206, 101, 1.0);

// const String host = 'http://10.10.10.130:8000';
const String host = 'https://www.olliekw.com';
const String endpoint = '$host/api';
const String polling_base = '$host/polling';
const String avatar_base = '$host/avatar';

InputDecoration inputDecoration(String hintText, [String errorText = null]) =>
    InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(8),
        ),
        /* borderSide: BorderSide(
        color: primaryColor,
        width: 1.0,
      ), */
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: appPadding * 2 / 3, vertical: appPadding / 4),
      fillColor: white,
      filled: true,
      errorText: errorText,
    );

Widget indicator([bool show]) {
  return show != null && show
      ? Container(
          color: Color(0x99000000),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(yellowColor),
              strokeWidth: 6,
            ),
          ),
        )
      : SizedBox();
}

List<String> parseToList(String json) {
  return List<String>.from(jsonDecode(json));
}

ImageProvider getAvatar(String avatar) {
  return avatar == null
      ? AssetImage("assets/images/avatar/placeholder.png")
      : Image.network('$avatar_base/$avatar').image;
}

String followerString(int follows) {
  int kFollows = (follows / 1000).round();
  return (kFollows > 0) ? "${kFollows}k Followers" : "$follows Followers";
}

String unit1000(int amount) {
  int kAmount = (amount / 1000).round();
  return (kAmount > 0) ? "$kAmount" : "$amount";
}

void goUserDetailPage(BuildContext context, User user) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserDetailPage(user: user),
    ),
  );
}

const double appPadding = 24.0;
