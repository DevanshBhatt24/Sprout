import 'package:Sprout/components/constant.dart';
import 'package:Sprout/screens/plantdescription.dart';
import 'package:Sprout/services/name.dart';
import 'package:Sprout/services/session.dart';
import 'package:Sprout/screens/login.dart';
import 'package:Sprout/screens/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/customroute.dart';

class ZenGarden extends StatefulWidget {
  const ZenGarden({Key? key}) : super(key: key);

  @override
  State<ZenGarden> createState() => _ZenGardenState();
}

class _ZenGardenState extends State<ZenGarden> {
  bool isloading = true;
  List<Name> plants = [];
  Session _session = Session();
  zenplant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cokkie = prefs.getString("cookie");
    // print(cokkie!.substring(4));
    Map<String, String?>? data = {'cookie': cokkie!.substring(4)};
    var response = await _session.post2(
        "https://sprout-plant-care-app.herokuapp.com/profile/mygarden", data);
    plants = response;
    print(plants);
    setState(() {
      isloading = false;
    });
    // print(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    zenplant();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffFCFFF6),
      child: isloading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xffFCFFF6),
                color: kPrimaryColor,
              ),
            )
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 50, 12, 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/mainpage");
                        },
                        icon: ImageIcon(
                          AssetImage("assets/images/chevron-left.png"),
                          color: kPrimaryColor,
                          size: 42,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "My Plants",
                      style:
                          kBigtext.copyWith(fontSize: 24, color: kPrimaryColor),
                    ),
                    SizedBox(
                      width: 140,
                    ),
                    InkWell(
                      onTap: (() {
                        Navigator.push(
                            context, CustomRoute(child: Searchpage()));
                      }),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: kPrimaryColor, shape: BoxShape.circle),
                        child: Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: ,
              // ),
              Expanded(
                // margin: EdgeInsets.symmetric(horizontal: )
                child: plants.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: plants.length,
                        itemBuilder: ((context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CustomRoute(
                                          child: PlantHomepage(
                                        Data: plants[index],
                                        iszen: true,
                                      )));
                                },
                                child: CustomCard(
                                  show: false,
                                  image: plants[index].image,
                                  txt: plants[index].name,
                                  name: plants[index].botname,
                                )))))
                    : Center(
                        child: Text(
                          "No plants to show.\n Add some plants ",
                          style: kSmalltext,
                        ),
                      ),
              ),
            ]),
    );
  }
}

// CustomCard(
//                         show: false,
//                         image: "assets/images/unsplash_CNgHaJwT5Pk.png",
//                         txt: "Lily",
//                       ))
class CustomCard extends StatefulWidget {
  final bool? show;
  final String? image;
  final String? txt;
  final String? name;
  CustomCard({this.show, this.image, this.txt, this.name});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
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
                    image: NetworkImage(widget.image!), fit: BoxFit.cover)),
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
