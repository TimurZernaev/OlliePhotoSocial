import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/components/dialog_box.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/action_button.dart';
import 'package:ollie_photo_social/pages/polling.dart';

class PollingCompletePage extends StatefulWidget {
  PollingCompletePage({Key key}) : super(key: key);

  @override
  _PollingCompletePageState createState() => _PollingCompletePageState();
}

class _PollingCompletePageState extends State<PollingCompletePage> {
  void nextAction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox.createOffline(context);
      },
    );
    /* Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PollingPage(),
      ),
    ); */
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Image(
              image: AssetImage('assets/images/layout/new_polling_topbar.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: appPadding * 2),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Congratulation!',
                  style: TextStyle(
                    color: white,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: appPadding * 2, vertical: appPadding * 2),
                  child: Image(
                      image:
                          AssetImage("assets/images/placeholder/complete.png"),
                      fit: BoxFit.cover),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: appPadding),
                  child: Text(
                    "Your Polling has been posted now.\nYou can check it on your feed \nor your profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          BottomNextIcon(
            complete: true,
            nextAction: nextAction,
          )
        ],
      ),
    );
  }
}
