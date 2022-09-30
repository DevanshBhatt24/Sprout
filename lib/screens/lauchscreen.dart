import 'package:Sprout/components/button.dart';
import '../components/customroute.dart';
import '../screens/login.dart';
import '../screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF4FAEA),
      child: Stack(children: [
        Positioned(
            top: 20,
            left: 0,
            right: 50,
            child: Container(
              child: Image(
                  image: AssetImage(
                      "assets/images/josh-calabrese-XXpbdU_31Sg-unsplash 2image2.png")),
            )),
        Positioned(
            bottom: 0,
            right: 0,
            left: 50,
            child: Container(
                child: Image(
              image: AssetImage(
                  "assets/images/josh-calabrese-XXpbdU_31Sg-unsplash 1image1.png"),
            ))),
        Positioned(
          top: 340,
          left: 100,
          child: Container(
            height: 156,
            width: 202,
            child: Image(
                image: AssetImage("assets/images/Artboard 1@4x 1image3.png")),
          ),
        ),
        Positioned(
            top: 620,
            left: 23,
            child: Button(
              color: Color(0xff496A5B),
              txt: "Log In",
              txtcolor: Colors.white,
              isboxdec: true,
              pressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LogIn()));
              },
            )),
        Positioned(
            top: 700,
            left: 23,
            child: Button(
              color: Colors.white.withOpacity(.86),
              txtcolor: Color(0xff496A5B),
              txt: "Create An Account",
              isboxdec: false,
              pressed: () {
                Navigator.push(context, CustomRoute(child: SignUp()));
              },
            )),
      ]),
    );
  }
}
