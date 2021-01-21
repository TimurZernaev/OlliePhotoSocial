import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/components/dash_line.dart';
import 'dart:math' as math;

class OfferCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: appPadding / 2),
      height: 120,
      child: CustomPaint(
        painter: CardShape(
          fillColor: grayColor,
          paintingStyle: PaintingStyle.fill,
        ),
        child: Container(
          padding: EdgeInsets.all(appPadding * 2 / 3),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/avatar/user1.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'PHEAST',
                      style: TextStyle(
                        color: gray3Color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                DashLine(size: 100 - appPadding, dashs: 10),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '20%',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'off',
                              style: TextStyle(
                                fontSize: 12,
                                color: gray3Color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Use 30 pts get this offer',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardShape extends CustomPainter {
  final Color fillColor;
  final PaintingStyle paintingStyle;

  CardShape(
      {this.fillColor = grayColor, this.paintingStyle = PaintingStyle.fill});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = fillColor
      ..style = paintingStyle;
    canvas.drawPath(shapePath(size.width, size.height), paint);
  }

  Path shapePath(double width, double height) {
    const double borderRadius = 8;
    const double gapRadius = appPadding / 2;
    Path cutPath = Path()
      ..arcTo(Rect.fromCircle(center: Offset(0, height / 2), radius: gapRadius),
          -math.pi / 2, math.pi, true)
      // ..lineTo(0, height / 2 - gapRadius)
      ..arcTo(
          Rect.fromCircle(center: Offset(width, height / 2), radius: gapRadius),
          math.pi / 2,
          math.pi,
          true);
    // ..lineTo(width, height / 2 + gapRadius)

    return Path.combine(
        PathOperation.difference,
        Path()
          ..addRRect(RRect.fromLTRBR(
              0, 0, width, height, Radius.circular(borderRadius))),
        cutPath);

    /*
      Path()
       ..moveTo(borderRadius, 0)
      ..lineTo(width - borderRadius, 0)
      ..addArc(
          Rect.fromCircle(
              center: Offset(width - borderRadius, borderRadius),
              radius: borderRadius),
          -math.pi / 2,
          math.pi / 2)
      ..lineTo(width, height / 2 - gapRadius)
      ..addArc(
          Rect.fromCircle(center: Offset(width, height / 2), radius: gapRadius),
          -math.pi / 2,
          -math.pi)
      ..lineTo(width, height - borderRadius)
      ..addArc(
          Rect.fromCircle(
              center: Offset(width - borderRadius, height - borderRadius),
              radius: borderRadius),
          0,
          math.pi / 2)
      ..lineTo(borderRadius, height)
      ..addArc(
          Rect.fromCircle(
              center: Offset(borderRadius, height - borderRadius),
              radius: borderRadius),
          math.pi / 2,
          math.pi / 2)
      ..lineTo(0, height / 2 + gapRadius)
      ..addArc(
          Rect.fromCircle(center: Offset(0, height / 2), radius: gapRadius),
          math.pi / 2,
          -math.pi)
      ..lineTo(0, borderRadius)
      ..addArc(
          Rect.fromCircle(
              center: Offset(borderRadius, borderRadius), radius: borderRadius),
          math.pi,
          math.pi / 2); */
  }

  @override
  bool shouldRepaint(CardShape oldDelegate) {
    return oldDelegate.fillColor != fillColor ||
        oldDelegate.paintingStyle != paintingStyle;
  }
}
