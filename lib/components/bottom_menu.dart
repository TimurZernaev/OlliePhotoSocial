import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/pages/home.dart';
import 'package:ollie_photo_social/pages/polling.dart';
import 'package:ollie_photo_social/pages/offers.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key key, this.isPolling}) : super(key: key);
  final bool isPolling;
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  setBottomBarIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => index == 0 ? HomePage() : OffersPage(),
      ),
    );
  }

  void addOrClose() {
    bool isPolling = widget.isPolling != null && widget.isPolling;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => isPolling ? HomePage() : PollingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool isPolling = widget.isPolling;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width,
            height: 80,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.18),
                blurRadius: 46,
                offset: Offset(2, 2),
              ),
            ]),
            child: Stack(
              overflow: Overflow.visible,
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: _CustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(
                      backgroundColor: primaryColor,
                      child: Icon(
                        (isPolling == null || !isPolling)
                            ? Icons.add
                            : Icons.close,
                        size: 32,
                      ),
                      elevation: 0.1,
                      onPressed: () => addOrClose()),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          size: 32,
                          color: currentIndex == 0
                              ? primaryColor
                              : Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setBottomBarIndex(context, 0);
                        },
                        splashColor: Colors.white,
                      ),
                      Container(
                        width: size.width * 0.20,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.loyalty_rounded,
                            size: 32,
                            color: currentIndex == 1
                                ? primaryColor
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(context, 1);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _CustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 50); // Start
    path.quadraticBezierTo(size.width * 0.5, 0, size.width, 50);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 50);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
