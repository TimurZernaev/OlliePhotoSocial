import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/yes_no.dart';
import 'package:ollie_photo_social/pages/polling_yes_detail.dart';
import 'package:ollie_photo_social/pages/user_detail.dart';

class YesNoCard extends StatefulWidget {
  final YesNo data;
  YesNoCard({Key key, @required this.data}) : super(key: key);

  @override
  _YesNoCardState createState() => _YesNoCardState();
}

class _YesNoCardState extends State<YesNoCard> {
  int currentIndex = 0;

  void goPollingYesDetailPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PollingYesDetailPage(data: widget.data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: appPadding / 3,
        horizontal: appPadding / 2,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: appPadding / 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => goUserDetailPage(context, data.user),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: getAvatar(data.user.avatar),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: appPadding / 6,
                      ),
                      child: Text(data.user.name),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: appPadding / 3,
                          ),
                          child: Text(data.end_time.split(' ').first),
                        ),
                        Image(
                          image: AssetImage(
                              data.is_group != null && data.is_group
                                  ? "assets/images/icon/group.png"
                                  : "assets/images/icon/map.png"),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: appPadding / 4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              InkWell(
                onTap: () => goPollingYesDetailPage(),
                child: Container(
                  margin: EdgeInsets.only(bottom: appPadding / 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      fit: BoxFit.cover,
                      image: Image.network('$polling_base/${data.images[0]}')
                          .image /* AssetImage('assets/images/data/' + data.images[0]) */,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: appPadding / 3,
                      vertical: appPadding / 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image(
                          image: AssetImage("assets/images/icon/back.png"),
                          width: 20,
                          height: 20,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: appPadding / 2),
                          child: Image(
                            image: AssetImage("assets/images/icon/no.png"),
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Image(
                          image: AssetImage("assets/images/icon/yes.png"),
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
