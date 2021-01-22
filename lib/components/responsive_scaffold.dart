import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatelessWidget {
  ResponsiveScaffold({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: this.child,
          ),
        ),
      ),
    );
  }
}
