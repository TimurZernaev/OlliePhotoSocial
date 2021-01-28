import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/yes_no.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class YesNoDetailCard extends StatefulWidget {
  final YesNo data;
  YesNoDetailCard({Key key, @required this.data}) : super(key: key);

  @override
  _YesNoDetailCardState createState() => _YesNoDetailCardState();
}

class _YesNoDetailCardState extends State<YesNoDetailCard> {
  PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  List<Widget> _buildCarousel(Size size) {
    return List.generate(
        widget.data.imageUrls.length, (index) => _buildPage(size, index));
  }

  Widget _buildPage(Size size, int idx) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/data/' + widget.data.imageUrls[idx]),
      ),
    );
  }

  Widget _buildCardTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          left: appPadding * 2,
          right: appPadding,
          top: appPadding,
          bottom: appPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(appPadding, 100),
          bottomLeft: Radius.elliptical(appPadding, 100),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: appPadding / 3,
        horizontal: appPadding / 2,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: appPadding / 3),
                    width: size.width * .5,
                    child: PageView(
                      children: _buildCarousel(size),
                      controller: _controller,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: appPadding * 2 / 3,
                        vertical: appPadding / 3,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage("assets/images/icon/back.png"),
                            width: 16,
                            height: 16,
                          ),
                          SizedBox(width: appPadding / 2),
                          Image(
                            image: AssetImage("assets/images/icon/no.png"),
                            width: 16,
                            height: 16,
                          ),
                          SizedBox(width: appPadding / 2),
                          Image(
                            image: AssetImage("assets/images/icon/yes.png"),
                            width: 16,
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: appPadding / 2),
          ScrollingPageIndicator(
            dotColor: primaryTrans2Color,
            dotSelectedColor: primaryColor,
            dotSize: 8,
            dotSelectedSize: 8,
            dotSpacing: 12,
            controller: _controller,
            itemCount: widget.data.imageUrls.length,
            orientation: Axis.horizontal,
          ),
          SizedBox(height: appPadding),
          Expanded(flex: 2, child: _buildCardTitle())
        ],
      ),
    );
  }
}
