import 'package:flutter/material.dart';
import 'package:ollie_photo_social/pages/home.dart';

import 'components/animated_splash.dart';

void main() {
  runApp(OllieApp());
}

class OllieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ollie Social',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplash(
        imagePath: 'assets/images/layout/splash.png',
        home: HomePage(title: 'Ollie Social Home'),
        duration: 800,
        type: AnimatedSplashType.StaticDuration,
      ),
    );
  }
}
