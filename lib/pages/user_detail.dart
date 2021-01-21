import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'package:ollie_photo_social/model/user.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UserDetailPage extends StatefulWidget {
  UserDetailPage({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage>
    with SingleTickerProviderStateMixin {
  Widget _buildPollItem(int index) {
    User user = userList[index];
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: grayColor,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/avatar/' + user.imageUrl),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: appPadding / 2,
                right: appPadding / 2,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: appPadding * 2 / 3, vertical: appPadding / 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryTransColor,
                ),
                child: Text(
                  '88%',
                  style: TextStyle(color: white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image(
            image: AssetImage('assets/images/layout/user_topbar.png'),
            fit: BoxFit.cover,
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                PollingBackIcon(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: appPadding,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: <Widget>[
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  width: 5.0,
                                  style: BorderStyle.solid),
                              color: Colors.black,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/avatar/${user.imageUrl}"),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 82, left: 76),
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: darkBlue.withOpacity(0.2),
                                      offset: Offset(5, 5),
                                      blurRadius: 20,
                                    ),
                                  ]),
                              child: Icon(
                                Icons.add,
                                color: white,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: appPadding * 2 / 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: appPadding * 2 / 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: appPadding / 3,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: gray2Color, width: .8),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "86",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("POLLINGS"),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: appPadding / 3,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: gray2Color, width: .8),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "12K",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("FOLLOWERS"),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: appPadding / 3,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "124",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("FOLLOWINGS"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      /* Expanded(child: Row()), */
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: appPadding),
                    child: StaggeredGridView.countBuilder(
                      primary: false,
                      crossAxisCount: 4,
                      mainAxisSpacing: appPadding / 2,
                      crossAxisSpacing: appPadding / 2,
                      itemCount: userList.length,
                      itemBuilder: (context, index) => _buildPollItem(index),
                      staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
