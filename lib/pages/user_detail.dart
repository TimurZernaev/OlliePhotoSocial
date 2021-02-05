import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'package:ollie_photo_social/model/multi.dart';
import 'package:ollie_photo_social/model/this_that.dart';
import 'package:ollie_photo_social/model/user.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ollie_photo_social/model/yes_no.dart';
import 'package:ollie_photo_social/module/request.dart';

class UserDetailPage extends StatefulWidget {
  UserDetailPage({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  Map profileInfo;
  List<YesNo> yesNoList = [];
  List<ThisThat> thisThatList = [];
  List<MultiChoice> multiList = [];

  @override
  void initState() {
    super.initState();
    getUserProfile();
    getPollings();
  }

  void getUserProfile() async {
    print('user id ${widget.user.id}');
    var res = await $get('/setting/profile/${widget.user.id}', true);
    setState(() {
      profileInfo = res;
    });
  }

  void getPollings() async {
    var res = await $get('/pollings/user/${widget.user.id}', true);
    setState(() {
      yesNoList = List<YesNo>.from(
          res['yes_list'].map((model) => YesNo.fromJson(model)));
      thisThatList = List<ThisThat>.from(
        res['this_list'].map((model) => ThisThat.fromJson(model)),
      );
      // multiList = List<MultiChoice>.from(
      //     res['multi_list'].map((model) => MultiChoice.fromJson(model)));
    });
  }

  void followingUser() async {
    var res = await $post('/setting/following/${widget.user.id}', {}, true);
    print(res);
  }

  Widget _buildPollItem(int index) {
    var image;
    if (index < yesNoList.length)
      image = yesNoList[index].images[0];
    else
      image = thisThatList[index - yesNoList.length].this_images[0];

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: grayColor,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Image(
              fit: BoxFit.cover,
              image: Image.network('$polling_base/$image').image,
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
                        children: [
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
                                image: getAvatar(
                                  user == null ? null : user.avatar,
                                ),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => followingUser(),
                            child: Container(
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
                                )),
                          )
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
                                  profileInfo == null
                                      ? ' '
                                      : unit1000(profileInfo['pollings']),
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
                                  profileInfo == null
                                      ? ' '
                                      : unit1000(profileInfo['followers']),
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
                                  profileInfo == null
                                      ? ' '
                                      : unit1000(profileInfo["followings"]),
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
                      itemCount: yesNoList.length + thisThatList.length,
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
