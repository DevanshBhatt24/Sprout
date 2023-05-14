import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

var boxdecoration = BoxDecoration(boxShadow: [
  BoxShadow(
    color: Color(0xff000000).withOpacity(.25),
    offset: Offset(
      0,
      4,
    ),
    blurRadius: 4,
    // spreadRadius: 2.0,
  ),
], borderRadius: BorderRadius.circular(20));
const kBigtext = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 35,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    color: Colors.black);

const kbigtext = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: kPrimaryColor,
  decoration: TextDecoration.none,
);
const kSmalltext = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: kPrimaryColor,
  decoration: TextDecoration.none,
);
const ksmalltext = TextStyle(
  fontFamily: 'Mada',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: kPrimaryColor,
  decoration: TextDecoration.none,
);
const kLighttext = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: kPrimaryColor,
  decoration: TextDecoration.none,
);
const kPrimaryColor = Color(0xff496A5B);
const kSecondaryColor = Color(0xffC6EBC3);
const kLightColor = Color(0xffF4FAEA);
var dec2 = InputDecoration(
    border: InputBorder.none,
    hintText: "Enter your password",
    hintStyle: kHintText,
    suffixIcon: Icon(
      FontAwesomeIcons.solidEye,
      color: Color(0xff5B5B5B),
      size: 14,
    ));
var dec = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide.none),
    hintText: "Enter your e-mail",
    fillColor: Color(0xfff3f3f3),
    filled: true,
    hintStyle: kHintText);
const kHintText = TextStyle(
  color: Color(0xffc9c9c9),
  fontSize: 16,
  fontFamily: 'Mada',
  fontWeight: FontWeight.w500,
);
const kColortext = TextStyle(
    color: Color(0xff17bb0a),
    fontFamily: 'Mada',
    fontSize: 16,
    fontWeight: FontWeight.w600);
const kHeadingtxt = TextStyle(
    color: Color(0xff393939),
    fontFamily: 'Mada',
    fontWeight: FontWeight.w700,
    fontSize: 20);
const kDescHeadingtxt = TextStyle(
  color: Color(0xff4b4b4b),
  fontFamily: 'Mada',
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
  fontSize: 30,
);
const kDescNametxt = TextStyle(
    color: Color(0xff4b4b4b),
    fontFamily: 'Mada',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    decoration: TextDecoration.none);
const kDescLighttxt = TextStyle(
    color: Color(0xff939393),
    fontFamily: 'Mada',
    fontWeight: FontWeight.w400,
    fontSize: 13,
    decoration: TextDecoration.none);
//   suffixIconColor: Color(0xff5b5b5b),
//   suffixIcon: GestureDetector(
//     onTap: pressed,
//     child: Icon(
//       showtext ? FontAwesomeIcons.solidEye : FontAwesomeIcons.eyeSlash,
//       size: 16,
//     ),
//   ),
// );
const kcartText = TextStyle(
    color: kPrimaryColor,
    fontFamily: 'Popins',
    fontSize: 18,
    fontWeight: FontWeight.w500);
const ktotalText = TextStyle(
    color: kPrimaryColor,
    fontFamily: 'Popins',
    fontSize: 20,
    fontWeight: FontWeight.w700);
const kplaceOrderButton = BoxDecoration(
  color: kPrimaryColor,
  borderRadius: BorderRadius.all(Radius.circular(8)),
);
const kOrderText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    fontSize: 18);

const ksucessBigText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    color: kPrimaryColor,
    fontWeight: FontWeight.w600);

const ksucessSmallText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: kPrimaryColor,
    fontWeight: FontWeight.w400);
