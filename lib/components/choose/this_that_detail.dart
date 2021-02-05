import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/model/this_that.dart';
import 'package:ollie_photo_social/model/yes_no.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class ThisThatDetailCard extends StatefulWidget {
  final ThisThat data;
  ThisThatDetailCard({Key key, @required this.data}) : super(key: key);

  @override
  _ThisThatDetailCardState createState() => _ThisThatDetailCardState();
}

class _ThisThatDetailCardState extends State<ThisThatDetailCard> {
  PageController _thisController, _thatController;
  bool thisSelected = false, thatSelected = false;

  @override
  void initState() {
    _thisController = PageController();
    _thatController = PageController();
    super.initState();
  }

  void back() {
    print('back pressed!');
  }

  String getYesImg(bool isThis) {
    if (isThis) {
      if (thisSelected != null && thisSelected)
        return "assets/images/icon/yes.png";
      else
        return "assets/images/icon/yes_inactive.png";
    } else {
      if (thatSelected != null && thatSelected)
        return "assets/images/icon/yes.png";
      else
        return "assets/images/icon/yes_inactive.png";
    }
  }

  void setRecommend(bool isThis) {
    setState(() {
      if (isThis) {
        thisSelected = true;
        thatSelected = false;
      } else {
        thisSelected = false;
        thatSelected = true;
      }
    });
  }

  List<Widget> _buildCarousel(Size size, bool isThis) {
    List images = isThis ? widget.data.this_images : widget.data.that_images;
    return List.generate(
        images.length, (index) => _buildPage(size, images[index]));
  }

  Widget _buildPage(Size size, String imgUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/data/${imgUrl}'),
      ),
    );
  }

  Widget _buildPageIndicator(bool isThis) {
    return Expanded(
      child: Column(children: [
        SizedBox(height: appPadding / 2),
        ScrollingPageIndicator(
          dotColor: primaryTrans2Color,
          dotSelectedColor: primaryColor,
          dotSize: 8,
          dotSelectedSize: 8,
          dotSpacing: 12,
          controller: isThis ? _thisController : _thatController,
          itemCount: isThis
              ? widget.data.this_images.length
              : widget.data.that_images.length,
          orientation: Axis.horizontal,
        ),
      ]),
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
      margin: EdgeInsets.symmetric(horizontal: appPadding),
      // height: 140,
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

  Widget _buildBackIcon() {
    return InkWell(
      onTap: () => back(),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Image(
          image: AssetImage("assets/images/icon/back.png"),
          width: 16,
          height: 16,
        ),
      ),
    );
  }

  Widget _buildImageComparer(Size size) {
    return Container(
      child: Row(
        children: [
          _buildImageSlider(size, true),
          SizedBox(width: appPadding),
          _buildImageSlider(size, false),
        ],
      ),
    );
  }

  Widget _buildImageSlider(Size size, bool isThis) {
    return Expanded(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: appPadding / 3),
            child: PageView(
              children: _buildCarousel(size, isThis),
              controller: isThis ? _thisController : _thatController,
            ),
          ),
          InkWell(
            onTap: () => setRecommend(isThis),
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
                  horizontal: appPadding * 1 / 2,
                  vertical: appPadding / 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage(getYesImg(isThis)),
                      width: 16,
                      height: 16,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: appPadding / 3,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                _buildImageComparer(size),
                _buildBackIcon(),
              ],
            ),
          ),
          Row(
            children: [
              _buildPageIndicator(true),
              SizedBox(
                width: appPadding,
              ),
              _buildPageIndicator(false),
            ],
          ),
          SizedBox(height: appPadding),
          Expanded(flex: 2, child: _buildCardTitle())
        ],
      ),
    );
  }
}
