import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/components/round_checkbox.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'package:ollie_photo_social/mock_data/user_data.dart';
import 'package:ollie_photo_social/model/polling.dart';
import 'package:ollie_photo_social/model/user.dart';
import 'package:ollie_photo_social/module/request.dart';
import 'package:ollie_photo_social/pages/polling_complete.dart';

class SharePage extends StatefulWidget {
  SharePage({Key key, this.data, this.type}) : super(key: key);
  final Map data;
  final PollingType type;

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  String dropdownValue = '1 hour';
  List<User> filteredUsers = userList;
  int filterType = 0;
  bool loading = false;

  Widget _buildShareUser(int index) {
    User user = filteredUsers[index];

    return Container(
      padding: EdgeInsets.all(appPadding * 2 / 3),
      margin: EdgeInsets.only(bottom: appPadding / 2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(appPadding),
          bottomRight: Radius.circular(appPadding),
        ),
        gradient:
            LinearGradient(colors: [primaryGrdStartColor, primaryGrdStopColor]),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: appPadding * 2,
                  width: appPadding * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: getAvatar(user.avatar),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  user.name,
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
            RoundCheckbox(),
          ]),
    );
  }

  void nextAction() async {
    Map data = widget.data;
    if (filterType == 0) data['fields']['share_to'] = 'public';
    if (filterType == 1)
      data['fields']['share_to'] = 'friends';
    else {
      data['fields']['share_to'] = ',' + filteredUsers.join(',') + ',';
    }
    setState(() {
      loading = true;
    });
    int statusCode = await $formUpload(
      AddPollingUrl[widget.type],
      data['fields'],
      data['files'],
    );
    setState(() {
      loading = false;
    });
    if (statusCode == 200)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PollingCompletePage(),
        ),
      );
    print(statusCode);
  }

  void filterUser(String text) {
    setState(() {
      filteredUsers = userList
          .where((user) => user.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  void setFilterType(int idx) {
    setState(() {
      filterType = idx;
    });
  }

  Widget _buildFilterItem(int idx) {
    TextStyle radioStyle = TextStyle(
      color: white,
      fontSize: 16, /* fontWeight: FontWeight.bold */
    );
    List icons = ['map_white.png', 'group_white.png', 'users_white.png'];
    List types = ['Publik', 'All Friends', 'Specific Friends'];

    return InkWell(
      onTap: () => setFilterType(idx),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: appPadding / 2, horizontal: appPadding / 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage("assets/images/icon/${icons[idx]}"),
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(types[idx], style: radioStyle)
              ],
            ),
            Container(
              width: 18,
              height: 18,
              margin: EdgeInsets.only(right: appPadding / 2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: filterType != idx ? white : Colors.transparent,
                      width: 1),
                  color: Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return filterType == 2
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20 + appPadding / 2),
            child: Container(
              padding: EdgeInsets.only(
                left: appPadding,
                right: appPadding / 2,
                top: appPadding / 8,
                bottom: appPadding / 8,
              ),
              color: grayColor,
              height: 40 + appPadding / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type name here",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 18),
                      onChanged: (text) => filterUser(text),
                    ),
                  ),
                  SizedBox(
                    width: appPadding / 3,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.all(appPadding / 6),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    child: Icon(Icons.add, color: white, size: 24),
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: 1,
          );
  }

  Widget _buildSearchedList(double width) {
    return filterType == 2
        ? Container(
            width: width,
            height: 300,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) => _buildShareUser(index),
            ),
          )
        : SizedBox();
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
                  title: 'Share to',
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(appPadding),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFilterItem(0),
                            Divider(
                              color: white,
                            ),
                            _buildFilterItem(1),
                            Divider(
                              color: white,
                            ),
                            _buildFilterItem(2),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        _buildSearchBar(),
                        _buildSearchedList(size.width),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Step 2 of 2', style: TextStyle(color: white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomNextIcon(
            nextAction: nextAction,
          ),
          indicator(loading),
        ],
      ),
    );
  }
}
