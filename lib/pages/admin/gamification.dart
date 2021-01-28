import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/components/dialog_box.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';

class GamificationPage extends StatefulWidget {
  GamificationPage({Key key}) : super(key: key);

  @override
  _GamificationPageState createState() => _GamificationPageState();
}

class _GamificationPageState extends State<GamificationPage> {
  void updateGamification() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox.createSuccess(
          context,
          'All changes has been saved.',
          () => Navigator.pop(context),
        );
      },
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
              image: AssetImage('assets/images/layout/new_polling_topbar.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                PollingBackIcon(
                  title: 'Gamification',
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(appPadding * 2),
                    // margin: EdgeInsets.only(top: appPadding),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Share points',
                                  style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 4),
                              TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: '10',
                                decoration: inputDecoration(''),
                              ),
                              SizedBox(height: appPadding),
                              Text('Fast reply',
                                  style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 4),
                              TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: '50',
                                decoration: inputDecoration(''),
                              ),
                              SizedBox(height: appPadding),
                              Text('Points every number of replys',
                                  style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 4),
                              TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: '10',
                                decoration: inputDecoration(''),
                              ),
                              SizedBox(height: appPadding),
                            ],
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          BottomNextIcon(nextAction: updateGamification),
        ],
      ),
    );
  }
}
