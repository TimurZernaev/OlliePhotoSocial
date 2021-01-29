import 'package:flutter/material.dart';

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

InputDecoration inputDecoration(String hintText) => InputDecoration(
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
    filled: true);
//default app padding

const double appPadding = 24.0;
