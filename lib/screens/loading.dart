import 'dart:async';
import 'dart:ffi';
import 'package:Sprout/components/constant.dart';
import 'package:Sprout/components/customroute.dart';
import 'package:Sprout/main.dart';
import 'package:Sprout/screens/lauchscreen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  final PageController? _controller = PageController();
  var _currPage = 0.0;
  bool islastpage = false;
  void initState() {
    // TODO: implement initState
    _controller!.addListener(() {
      setState(() {
        _currPage = _controller!.page!;
      });
    });
    // navigateUser();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  List txt = [
    "Add plants to your garden",
    "Join community to learn more",
    "Create smart reminders",
    "Learn how to care plant"
  ];
  List step = [
    "Step 1",
    "Step 2",
    "Step 3",
    "Step 4",
  ];
  List images = [
    "assets/images/unsplash_ncQ2sguVlgo.png",
    "assets/images/unsplash_Ts0830UlVOM.png",
    "assets/images/unsplash_jOeh3Lv88xA.png",
    "assets/images/unsplash_H0iAXFekiWo.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        color: Color(0xffF4FAEA),
        child: Container(
          child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  islastpage = index == 3;
                });
              },
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemCount: 4,
              itemBuilder: (context, index) => CustomContainer(
                  step: step[index],
                  txt: txt[index],
                  image: images[index],
                  ontap: () => Timer(
                        Duration(milliseconds: 1000),
                        () => _controller!.animateToPage(3,
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 300)),
                      ))),
        ),
        //   SizedBox(
        //     height: 10,
        //   ),
        //   DotsIndicator(
        //     dotsCount: 4,
        //     position: _currPage,
        //     decorator: DotsDecorator(
        //       activeColor: kPrimaryColor,
        //       size: const Size.square(9.0),
        //       activeSize: const Size(9.0, 9.0),
        //       activeShape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(5.0)),
        //     ),
        //   )
        // ]),
      ),
      bottomSheet: islastpage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  primary: Colors.white,
                  backgroundColor: kPrimaryColor,
                  minimumSize: Size.fromHeight(65)),
              onPressed: () => navigateUser(LaunchScreen()),
              child: Text(
                'Get started',
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ))
          : Container(
              padding: EdgeInsets.symmetric(),
              height: 80,
              color: Color(0xffF4FAEA),
              child: Row(children: [
                SizedBox(width: 145),
                SmoothPageIndicator(
                  count: 4,
                  controller: _controller!,
                  effect: WormEffect(
                      activeDotColor: kPrimaryColor,
                      spacing: 16,
                      dotHeight: 12,
                      dotWidth: 12),
                  onDotClicked: (index) => _controller!.animateToPage(index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
                ),
                SizedBox(
                  width: 70,
                ),
                TextButton(
                    onPressed: () {
                      _controller!.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: Text(
                      "NEXT",
                      style: kSmalltext.copyWith(fontWeight: FontWeight.w500),
                    ))
              ]),
            ),
    );
  }

  void navigateUser(Widget child) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getString('token');
    if (status != null) {
      Navigator.push(context, CustomRoute(child: MainPage()));
    } else {
      Navigator.push(context, CustomRoute(child: child));
    }
  }
}

class CustomContainer extends StatelessWidget {
  String? image;
  String? txt;
  String? step;
  Function()? ontap;
  CustomContainer({this.step, this.txt, this.image, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .9,
        width: MediaQuery.of(context).size.width * .95,
        child: Stack(
          children: [
            Positioned(
                top: 30,
                right: 10,
                child: TextButton(
                  child: Text(
                    "Skip",
                    style: kSmalltext.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  onPressed: ontap,
                )),
            Positioned(
                top: 120,
                left: 0,
                child: Container(
                  height: 43,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: Color(0xff17bb0a)),
                  child: Center(
                      child: Text(
                    step!,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Mada',
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
                )),
            Positioned(
                top: 220,
                left: 35,
                child: Container(
                  height: 80,
                  child: Stack(
                    children: [
                      Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.15),
                                  blurRadius: 2,
                                  offset: Offset(0, 1))
                            ]),
                        child: Center(
                            child: Text(
                          txt!,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Mada',
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 50,
                        child: ClipPath(
                          clipper: CustomTriangleClipper(),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.15),
                                  blurRadius: 2,
                                  offset: Offset(0, 1))
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
              top: 325,
              left: 5,
              child: Container(
                height: 321,
                width: 377,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: AssetImage(image!))),
              ),
            ),
          ],
        ));
  }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
