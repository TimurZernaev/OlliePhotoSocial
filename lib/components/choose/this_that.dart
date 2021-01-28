import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/this_that.dart';
import 'package:ollie_photo_social/pages/polling_this_detail.dart';

class ThisThatCard extends StatefulWidget {
  final ThisThat data;
  ThisThatCard({Key key, @required this.data}) : super(key: key);

  @override
  _ThisThatCardState createState() => _ThisThatCardState();
}

class _ThisThatCardState extends State<ThisThatCard> {
  int currentIndex = 0;

  void goPollingThisDetailPage(ThisThat data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PollingThisDetailPage(data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    Size size = MediaQuery.of(context).size;

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
                Container(
                  margin: EdgeInsets.only(
                    right: 10,
                  ),
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/avatar/" + data.user.imageUrl),
                      fit: BoxFit.fitWidth,
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
                          child: Text(data.time),
                        ),
                        Image(
                          image: AssetImage(data.isGroup
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
          SizedBox(height: appPadding / 4),
          Row(
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
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: appPadding / 3),
                height: size.height / 3,
                child: InkWell(
                  onTap: () => goPollingThisDetailPage(data),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/data/' +
                                  data.thisImageUrls[0]),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/data/' +
                                  data.thatImageUrls[0]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(0),
                  ),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: appPadding / 3,
                      vertical: appPadding / 3,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image(
                          image: AssetImage("assets/images/icon/yes.png"),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(height: appPadding / 2),
                        Image(
                          image: AssetImage("assets/images/icon/back.png"),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(height: appPadding / 2),
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
