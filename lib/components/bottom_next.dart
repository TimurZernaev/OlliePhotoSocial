import 'package:flutter/material.dart';

class BottomNextIcon extends StatelessWidget {
  const BottomNextIcon({Key key, this.complete, this.nextAction, this.primary})
      : super(key: key);
  final bool complete;
  final void Function() nextAction;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _primary = primary == null ? false : primary;

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
                      image: AssetImage(_primary
                          ? "assets/images/layout/bottom_back_primary.png"
                          : "assets/images/layout/bottom_back.png"),
                      fit: BoxFit.cover),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: size.width / 12, top: size.width / 12),
                child: Icon(
                  (this.complete == null || !this.complete)
                      ? Icons.arrow_forward
                      : Icons.check,
                  color: _primary ? Colors.white : Colors.black,
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
