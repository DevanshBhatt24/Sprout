import 'package:Sprout/components/constant.dart';
import 'package:Sprout/components/customroute.dart';
import 'package:Sprout/components/plantorder/cart/shopcart.dart';
import 'package:Sprout/screens/account.dart';
import 'package:Sprout/screens/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatelessWidget {
  final bool? isSearch;
  SearchWidget({this.isSearch});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(CustomRoute(builder: (context) => Searchpage())),
          child: Container(
              height: 47,
              width: isSearch! ? 310 : 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: Color(0xfffefefe),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3, color: Colors.black.withOpacity(.25))
                  ]),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage("assets/images/search.png"),
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Search plant",
                    style: kHintText.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    width: 105,
                  ),
                  ImageIcon(AssetImage(
                      "assets/images/fluent_scan-dash-16-regular.png"))
                ],
              )),
        ),
        SizedBox(
          width: 12,
        ),
        isSearch!
            ? Container()
            : InkWell(
                onTap: (() {
                  Navigator.of(context).push(
                      CustomRoute(builder: (context) => Accountdetails()));
                }),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Color(0xff24881b)),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/pexels-matheus-bertelli-573259-1024x683.jpg"),
                          fit: BoxFit.cover)),
                ),
              )
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  SearchBar();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(CustomRoute(builder: (context) => Searchpage())),
          child: Container(
              height: 45,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: Color(0xfffefefe),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3, color: Colors.black.withOpacity(.25))
                  ]),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage("assets/images/search.png"),
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Search plant",
                    style: kHintText.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    width: 55,
                  ),
                  ImageIcon(AssetImage(
                      "assets/images/fluent_scan-dash-16-regular.png"))
                ],
              )),
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () => Navigator.of(context)
              .push(CustomRoute(builder: (context) => Cart())),
          child: ImageIcon(
            AssetImage("assets/images/shopping-cart.png"),
            size: 28,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: (() {
            Navigator.of(context)
                .push(CustomRoute(builder: (context) => Accountdetails()));
          }),
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Color(0xff24881b)),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/pexels-matheus-bertelli-573259-1024x683.jpg"),
                    fit: BoxFit.cover)),
          ),
        )
      ],
    );
  }
}
