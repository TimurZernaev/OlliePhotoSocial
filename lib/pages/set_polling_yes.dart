import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'package:ollie_photo_social/model/polling.dart';
import 'package:ollie_photo_social/module/request.dart';
import 'package:ollie_photo_social/pages/share.dart';

class SetPollingYesPage extends StatefulWidget {
  SetPollingYesPage({
    Key key,
    this.selectedIndex,
    this.imagePath,
    this.createMode,
    this.photosPath,
  }) : super(key: key);

  final int selectedIndex;
  final String imagePath;
  final bool createMode;
  final List<String> photosPath;

  @override
  _SetPollingYesPageState createState() => _SetPollingYesPageState();
}

class _SetPollingYesPageState extends State<SetPollingYesPage> {
  String dropdownValue = '1 hour';
  PageController _controller;
  String title;
  bool titleError = false;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  void nextAction() {
    if (title == null || title.isEmpty) {
      return setState(() => titleError = true);
    }
    Map data = {
      'fields': {
        'title': title,
        'duration': dropdownValue,
      },
      'files': {
        'yes_image': widget.photosPath,
      }
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SharePage(type: PollingType.yes_no, data: data),
      ),
    );
  }

  List<Widget> _buildCarousel(Size size) {
    return List.generate(
        widget.photosPath.length, (index) => _buildPage(size, index));
  }

  Widget _buildPage(Size size, int idx) {
    return Container(
      width: size.width,
      height: size.height * .4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(appPadding * 2 / 3),
        image: DecorationImage(
            image: Image.file(File(widget.photosPath[idx])).image,
            fit: BoxFit.cover),
      ),
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
              image: AssetImage("assets/images/layout/new_polling_topbar.png"),
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  PollingBackIcon(
                    title: "Add New Polling",
                  ),
                  Container(
                    padding: EdgeInsets.all(appPadding),
                    margin: EdgeInsets.only(bottom: appPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width,
                          height: size.height * .4,
                          child: PageView(
                            children: _buildCarousel(size),
                            controller: _controller,
                          ),
                        ),
                        SizedBox(height: appPadding),
                        Text('Title', style: TextStyle(color: white)),
                        SizedBox(height: appPadding / 4),
                        TextField(
                          textAlign: TextAlign.left,
                          onChanged: (text) => setState(() {
                            title = text;
                            if (text != null && text.isNotEmpty)
                              titleError = false;
                          }),
                          decoration: inputDecoration(
                              'Write your question here',
                              titleError ? 'Title is required' : null),
                        ),
                        SizedBox(height: appPadding),
                        Text('Polling Duration',
                            style: TextStyle(color: white)),
                        SizedBox(height: appPadding / 2),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: appPadding / 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: primaryColor),
                            color: white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 0,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: null,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                '1 hour',
                                '3 hours',
                                'a day',
                                'a week',
                                'a month'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(
                                          fontSize: 14, color: black)),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(left: appPadding, bottom: appPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Step 1 of 2', style: TextStyle(color: white)),
              ],
            ),
          ),
          BottomNextIcon(
            nextAction: nextAction,
          )
        ],
      ),
    );
  }
}
