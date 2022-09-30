import 'package:Sprout/components/constant.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? txt;
  final Color? color;
  final bool? isboxdec;
  final Color? txtcolor;
  final Function()? pressed;
  Button({this.txt, this.txtcolor, this.isboxdec, this.pressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isboxdec! ? boxdecoration : null,
      child: FlatButton(
          minWidth: 350,
          height: 56,
          onPressed: pressed,
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text(
            txt!,
            style: kSmalltext.copyWith(color: txtcolor),
          )),
    );
  }
}
