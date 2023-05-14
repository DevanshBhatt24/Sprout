import 'package:Sprout/components/button.dart';
import 'package:Sprout/components/constant.dart';
import 'package:Sprout/screens/SearchPalnts.dart';
import 'package:Sprout/screens/shop/ShopTab/All.dart';
import 'package:Sprout/screens/shop/ShopTab/Herbs.dart';
import 'package:Sprout/screens/shop/ShopTab/IndoorPlants.dart';
import 'package:Sprout/screens/shop/ShopTab/OutdooePlants.dart';
import 'package:Sprout/screens/login.dart';
import 'package:Sprout/screens/searchpage.dart';
import 'package:Sprout/screens/signup.dart';
import 'package:Sprout/services/name.dart';
import 'package:flutter/material.dart';
import '../../components/searchbar.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  int? index;

  List<String>? items = [
    "All",
    "Indoor plants",
    "Outdoor plants",
    "Medicines",
  ];
  List<Widget>? tab = [AllPlants(), IndoorPlants(), OutdoorPlants(), Herbs()];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xfffcfff6),
      child: Container(
          margin: EdgeInsets.fromLTRB(16, 60, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 47,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: items!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                        onTap: (() {
                          setState(() {
                            current = index;
                          });
                        }),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          constraints: BoxConstraints(maxHeight: 47),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              items![index],
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: current == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: current == index
                                  ? kPrimaryColor
                                  : Color(0xffE6E6E6),
                              borderRadius: current == index
                                  ? BorderRadius.all(Radius.circular(12))
                                  : BorderRadius.all(Radius.circular(8))),
                        ));
                  }),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  height: 590, width: double.infinity, child: tab![current]),
            ],
          )),
    );
  }
}
