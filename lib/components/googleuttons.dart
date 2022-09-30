import 'package:Sprout/components/constant.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  Buttons();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(4, 2, 14, 2),
      height: 50,
      width: 210,
      decoration: BoxDecoration(
          color: Colors.blueAccent, borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                  image: AssetImage("assets/images/google1.png"), scale: 2)),
        ),
        Text(
          "Sign in with Google",
          style: ksmalltext.copyWith(color: Colors.white),
        )
      ]),
    );
  }
}
