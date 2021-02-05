import 'package:ollie_photo_social/pages/signin.dart';

import 'components/animated_splash.dart';
import 'package:flutter/material.dart';

class OllieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ollie Social',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: 'Gotham',
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplash(
        imagePath: 'assets/images/layout/splash.png',
        home: SigninPage(),
        // home: HomePage(title: 'Ollie Social Home'),
        duration: 800,
        type: AnimatedSplashType.StaticDuration,
      ),
    );
  }
}
