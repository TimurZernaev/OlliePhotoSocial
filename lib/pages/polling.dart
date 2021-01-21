import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_menu.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/pages/polling_multi.dart';
import 'package:ollie_photo_social/pages/polling_this.dart';
import 'package:ollie_photo_social/pages/polling_yes.dart';

class PollingPage extends StatefulWidget {
  PollingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PollingPageState createState() => _PollingPageState();
}

class _PollingPageState extends State<PollingPage> {
  void _navigatePollingTypePage(int idx) {
    Widget routeWidget;
    switch (idx) {
      case 1:
        routeWidget = PollingThisPage();
        break;
      case 2:
        routeWidget = PollingMultiPage();
        break;
      case 0:
      default:
        routeWidget = PollingYesPage(
          selectedIndex: 0,
          createMode: true,
          photosPath: [],
        );
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => routeWidget),
    );
  }

  Widget _buildPollingCard(
      int idx, String icon, String title, String subtitle) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _navigatePollingTypePage(idx),
      child: Container(
        margin: EdgeInsets.only(
          top: appPadding,
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              height: size.height / 7 - appPadding * 2 / 3,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: darkBlue.withOpacity(0.1),
                    offset: Offset(0, 5),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: white,
                      padding: EdgeInsets.only(
                          left: size.height / 7 + appPadding / 2, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: appPadding / 4),
                            child: Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(subtitle,
                              style: TextStyle(color: Colors.grey.shade500)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.height / 7,
              height: size.height / 7,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: darkBlue.withOpacity(0.1),
                    offset: Offset(10, 0),
                    blurRadius: 5,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: EdgeInsets.all(
                    appPadding / 2,
                  ),
                  color: white,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/icon/' + icon),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
            child: Image(
              image: AssetImage('assets/images/layout/polling_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: appPadding * 2.5,
              left: appPadding,
              right: appPadding,
            ),
            child: Column(
              children: [
                Text(
                  "Choose Your Pooling",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: white,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildPollingCard(
                      0,
                      'yesno.png',
                      'Yes or No',
                      'Asking votes for your photo.',
                    ),
                    _buildPollingCard(
                      1,
                      'thisthat.png',
                      'This or That',
                      'People votes between two photos.',
                    ),
                    _buildPollingCard(
                      2,
                      'multichoice.png',
                      'Multiple Choice',
                      'Giving your question in words.',
                    ),
                  ],
                )
              ],
            ),
          ),
          BottomNavBar(
            isPolling: true,
          ),
          /* StatusDialog(
            title: 'Block User',
            message: 'Do you want to block this user',
            state: ActionState.blocked,
            buttons: [
              ActionButton(text: 'No', filled: false),
              ActionButton(text: 'yes'),
            ],
          ) */
        ],
      ),
    );
  }
}
