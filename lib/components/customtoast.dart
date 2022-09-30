import 'package:flutter/material.dart';

class customToast extends StatelessWidget {
  customToast({this.txt});
  String? txt;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  offset: Offset(
                    1.0,
                    1.0,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ]),
          child: Text(txt!),
        ),
      ]),
    );
  }
}
