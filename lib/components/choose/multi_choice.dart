import 'package:flutter/material.dart';
import 'package:ollie_photo_social/components/block_raised_button.dart';
import 'package:ollie_photo_social/components/round_checkbox.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/multi.dart';

class MultiChoiceCard extends StatefulWidget {
  final MultiChoice data;
  MultiChoiceCard({Key key, @required this.data}) : super(key: key);

  @override
  _MultiChoiceCardState createState() => _MultiChoiceCardState();
}

class _MultiChoiceCardState extends State<MultiChoiceCard> {
  int currentIndex = 0;

  Widget _buildChoiceItem(String choice) {
    return Container(
      margin: EdgeInsets.only(bottom: appPadding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: gray2Color,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: appPadding / 2,
        vertical: appPadding / 3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(choice, style: TextStyle()),
          RoundCheckbox(),
        ],
      ),
    );
  }

  List<Widget> _buildChoiceList() {
    List<Widget> choiceList = [];
    for (var choice in widget.data.choices) {
      choiceList.add(_buildChoiceItem(choice));
    }
    return choiceList;
  }

  Widget _buildCardTitle() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: appPadding * 2),
          padding: EdgeInsets.only(
              left: appPadding * 2,
              right: appPadding,
              top: appPadding,
              bottom: appPadding),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(appPadding * 1.2),
              bottomLeft: Radius.circular(appPadding * 1.2),
              topRight: Radius.circular(appPadding * .8),
              bottomRight: Radius.circular(appPadding * .8),
            ),
            color: primaryColor,
            image: DecorationImage(
              image: AssetImage("assets/images/layout/multi_wave.png"),
              fit: BoxFit.fitHeight,
              alignment: Alignment.topLeft,
            ),
          ),
          child: Text(
            widget.data.title,
            style: TextStyle(
              color: white,
              fontSize: 18,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => goUserDetailPage(context, widget.data.user),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white, width: 4.0, style: BorderStyle.solid),
              color: Colors.black,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: getAvatar(widget.data.user.avatar),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: appPadding,
      ),
      margin: EdgeInsets.only(bottom: appPadding / 2),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildCardTitle(),
          SizedBox(
            height: appPadding / 2,
          ),
          Container(
            child: Column(children: _buildChoiceList()),
          ),
          BlockRaisedButton(
            label: 'Send Answer',
            color: yellowColor,
            textColor: white,
          ),
          /* SizedBox(
            width: double.infinity,
            child: ButtonTheme(
              child: RaisedButton(
                textColor: white,
                color: yellowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: yellowColor),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: appPadding / 2, horizontal: appPadding / 2),
                onPressed: () {},
                child: Text(
                  'Send Answer',
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ), */
        ],
      ),
    );
  }
}
