import 'package:flutter/material.dart';

class Textcontainer extends StatelessWidget {
  Widget? child;
  Textcontainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      width: 355,
      height: 51,
      decoration: BoxDecoration(
          color: Color(0xffF3F3F3), borderRadius: BorderRadius.circular(15)),
      child: child,
    );
  }
}
