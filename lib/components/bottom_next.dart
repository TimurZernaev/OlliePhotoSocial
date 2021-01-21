import 'package:flutter/material.dart';

class BottomNextIcon extends StatelessWidget {
  const BottomNextIcon({Key key, this.complete, this.nextAction})
      : super(key: key);
  final bool complete;
  final void Function() nextAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: size.width / 4,
            height: size.width / 4,
            child: GestureDetector(
              onTap: () => nextAction != null ? nextAction() : {},
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/layout/bottom_back.png"),
                      fit: BoxFit.cover),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: size.width / 12, top: size.width / 12),
                child: Icon(
                  (this.complete == null || !this.complete)
                      ? Icons.arrow_forward
                      : Icons.check,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
