import 'package:Sprout/screens/plantdescription.dart';
import 'package:Sprout/screens/SearchPalnts.dart';
import 'package:Sprout/services/name.dart';
import 'package:Sprout/screens/zengarden.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../components/constant.dart';
import '../components/customroute.dart';
import '../components/searchbar.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final plants = [
    "African sheepbush",
    "Alder",
    "Black alder",
    "Common alder",
    "False alder",
    "Gray alder",
    "Speckled alder",
    "White alder",
    "Almond",
    "Aloe vera",
    "Amaranth",
    "Foxtail amaranth",
    "Ambrosia",
    "Tall ambrosia",
    "Amy root",
    "Angel trumpet",
    "Apple",
    "Apricot",
    "Arfaj",
    "Arizona sycamore",
    "Arrowwood",
    "Indian arrowwood",
    "Ash",
    "Black ash",
    "Blue ash",
    "Cane ash",
    "European ash",
    "Green ash",
    "Maple ash",
    "Red ash",
    "River ash",
    "Swamp ash",
    "White ash",
    "Water ash",
    "Azolla",
    "Carolina"
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xfffcfff6),
        child: Container(
            margin: EdgeInsets.fromLTRB(6, 70, 6, 5),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchWidget2(),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      widthFactor: 1.2,
                      child: Text(
                        "Popular Plants",
                        style: TextStyle(
                            fontFamily: 'Popins',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: kPrimaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCard2(
                          show: false,
                          image:
                              "assets/images/WhatsApp Image 2022-05-28 at 5.40.21 PM.jpeg",
                          name: "Alovera",
                        ),
                        CustomCard2(
                          show: false,
                          image:
                              "assets/images/WhatsApp Image 2022-05-28 at 5.40.25 PM.jpeg",
                          name: "Jasmine",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCard2(
                          show: false,
                          image:
                              "assets/images/WhatsApp Image 2022-05-28 at 5.40.30 PM .jpeg",
                          name: "Dahlia",
                        ),
                        CustomCard2(
                          show: false,
                          image:
                              "assets/images/WhatsApp Image 2022-05-28 at 5.40.33 PM.jpeg",
                          name: "Rose",
                        ),
                      ],
                    ),
                  ]),
            )));
  }
}

class SearchWidget2 extends StatefulWidget {
  const SearchWidget2({Key? key}) : super(key: key);

  @override
  State<SearchWidget2> createState() => _SearchWidget2State();
}

class _SearchWidget2State extends State<SearchWidget2> {
  TextEditingController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              FontAwesomeIcons.angleLeft,
              color: kPrimaryColor,
              size: 25,
            ),
          ),
          Container(
            height: 47,
            width: 310,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                color: Color(0xfffefefe),
                border: Border.all(width: 1, color: Color(0xff17bb0a))),
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 2),
            child: TextField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Image.asset(
                      "assets/images/fluent_scan-dash-16-regular.png"),
                  onPressed: () {},
                ),
                hintText: "Search plant",
                hintStyle: kHintText.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 18),
                border: InputBorder.none,
              ),
              style: styleHint,
              onSubmitted: (value) {
                Navigator.push(
                    context,
                    CustomRoute(
                        child: SearchPlant(
                      data: value,
                    )));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCard2 extends StatefulWidget {
  final bool? show;
  final String? image;
  final String? txt;
  final String? name;
  CustomCard2({this.show, this.image, this.txt, this.name});

  @override
  State<CustomCard2> createState() => _CustomCard2State();
}

class _CustomCard2State extends State<CustomCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 190,
      child: Stack(children: [
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            height: 170,
            width: 170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: DecorationImage(
                    image: AssetImage(widget.image!), fit: BoxFit.cover)),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: widget.show!
              ? Container(
                  height: 22,
                  width: 22,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFCFFF6),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffff3b3b),
                    ),
                  ),
                )
              : Container(),
        ),
        Positioned(
          bottom: 0,
          left: 18,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${widget.name!}",
                style: kHeadingtxt.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
