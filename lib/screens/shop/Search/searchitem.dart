import 'package:Sprout/screens/plantdescription.dart';
import 'package:Sprout/screens/SearchPalnts.dart';
import 'package:Sprout/screens/shop/Search/shopsearch.dart';
import 'package:Sprout/services/name.dart';
import 'package:Sprout/screens/zengarden.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../components/constant.dart';
import '../../../components/customroute.dart';

class SearchItem extends StatefulWidget {
  SearchItem();

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xfffcfff6),
        child: Container(
            margin: EdgeInsets.fromLTRB(6, 60, 6, 5),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchWidget2(),
                    SizedBox(
                      height: 30,
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
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Image.asset(
                      "assets/images/fluent_scan-dash-16-regular.png"),
                  onPressed: () {},
                ),
                hintText: "Search",
                hintStyle: kHintText.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 18),
                border: InputBorder.none,
              ),
              style: styleHint,
              onSubmitted: (value) {
                Navigator.of(context).push(CustomRoute(
                    builder: (context) => SearchShop(
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
