import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/bottom_next.dart';
import 'package:ollie_photo_social/components/responsive_scaffold.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/polling_back_icon.dart';
import 'package:ollie_photo_social/model/polling.dart';
import 'package:ollie_photo_social/pages/share.dart';

class PollingMultiPage extends StatefulWidget {
  PollingMultiPage({Key key}) : super(key: key);

  @override
  _PollingMultiPageState createState() => _PollingMultiPageState();
}

class _PollingMultiPageState extends State<PollingMultiPage> {
  String dropdownValue = '1 hour';
  int optionsLength = 2;
  List<String> optionsTitle = [null, null];
  bool titleError = false;
  List<bool> optionsError = [false, false];
  String title;

  void nextAction() {
    Iterable emptyOptions =
        optionsTitle.where((title) => title == null || title.isEmpty);
    if (emptyOptions.length > 0) {
      return setState(() {
        optionsTitle.asMap().forEach((index, title) {
          if (title == null || title.isEmpty) optionsError[index] = true;
        });
      });
    }
    Map data = {
      'fields': {
        'title': title,
        'duration': dropdownValue,
        'options': jsonEncode(optionsTitle)
      },
      'files': null
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SharePage(type: PollingType.multiple, data: data),
      ),
    );
  }

  void addOption() {
    setState(() {
      if (optionsLength == 4) return;
      optionsLength++;
      optionsTitle.add(null);
      optionsError.add(false);
    });
  }

  Widget _buildOptionsList() {
    List<Widget> options = [];
    for (var i = 0; i < optionsLength; i++) {
      options.add(_buildOptionItem(i));
    }
    return Column(children: options);
  }

  Widget _buildOptionItem(int idx) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Option ${idx + 1}', style: TextStyle(color: white)),
          SizedBox(height: appPadding / 4),
          TextField(
            textAlign: TextAlign.left,
            decoration: inputDecoration(
              'Answer question ${idx + 1}',
              optionsError[idx] ? 'Answer is required' : null,
            ),
            onChanged: (text) => setState(() {
              optionsTitle[idx] = text;
              if (text != null && text.isNotEmpty) optionsError[idx] = false;
            }),
          ),
          SizedBox(height: appPadding * 2 / 3),
        ],
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
              image: AssetImage('assets/images/layout/new_polling_topbar.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                PollingBackIcon(
                  title: 'Add New Polling',
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(appPadding),
                    // margin: EdgeInsets.only(top: appPadding),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title', style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 4),
                              TextField(
                                textAlign: TextAlign.left,
                                decoration: inputDecoration(
                                  'Write your question here',
                                  titleError ? 'Title is required' : null,
                                ),
                                onChanged: (text) =>
                                    setState(() => title = text),
                              ),
                              SizedBox(height: appPadding),
                              _buildOptionsList(),
                              optionsLength < 4
                                  ? InkWell(
                                      onTap: () => addOption(),
                                      child: Text(
                                        '+ Add Option',
                                        style: TextStyle(color: Colors.yellow),
                                      ),
                                    )
                                  : SizedBox(height: 1),
                              SizedBox(height: appPadding),
                              Text('Polling Duration',
                                  style: TextStyle(color: white)),
                              SizedBox(height: appPadding / 2),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: appPadding / 2),
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
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
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
                          Text('Step 1 of 2', style: TextStyle(color: white)),
                        ]),
                  ),
                ),
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
