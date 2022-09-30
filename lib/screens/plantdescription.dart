import 'dart:async';
import 'dart:convert';
import 'package:Sprout/components/customroute.dart';
import 'package:Sprout/screens/zengarden.dart';
import 'package:Sprout/services/session.dart';
import 'package:Sprout/main.dart';
import 'package:Sprout/screens/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Sprout/components/constant.dart';
import 'package:Sprout/services/name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/customtoast.dart';

class PlantHomepage extends StatefulWidget {
  final Name? Data;
  bool? iszen;
  PlantHomepage({this.iszen, this.Data});

  @override
  State<PlantHomepage> createState() => _PlantHomepageState();
}

class _PlantHomepageState extends State<PlantHomepage> {
  bool? isselected;
  Name? data;
  Cookie? select;
  bool? isloading = false;
  Session _session = Session();
  FToast? _fToast;
  String? cook;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.Data!;
    _fToast = FToast();
    _fToast!.init(context);
    select = Provider.of<Cookie>(context, listen: false);

    isselected = select!.isselected;

    // print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return data != null || isloading!
        ? Material(
            child: Stack(children: [
              Container(
                height: 428,
                width: MediaQuery.of(context).size.width,
                child: Image(image: NetworkImage(data!.image!)),
              ),
              Positioned(
                top: 30,
                left: 5,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: ImageIcon(
                      AssetImage("assets/images/chevron-left.png"),
                      color: Colors.white,
                      size: 42,
                    )),
              ),
              Positioned(
                top: 328,
                child: Container(
                  height: 520,
                  padding: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data!.name!,
                          style: kDescHeadingtxt,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              "Common name:",
                              style: kDescNametxt,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              data!.name!,
                              style: kDescNametxt.copyWith(
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Botanical name:",
                              style: kDescNametxt,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              data!.botname!,
                              style: kDescNametxt.copyWith(
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            DescContainer(
                              txt: "Soil Moist",
                              image: "assets/images/icons8-water-100 1.png",
                              value:
                                  "${data!.soilmoist}-${data!.minsoilmoist}°C",
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DescContainer(
                              txt: "Temprature",
                              image:
                                  "assets/images/fluent_temperature-16-regular.png",
                              value: "${data!.maxtemp}-${data!.temp}°C",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            DescContainer(
                              txt: "Light",
                              image: "assets/images/bi_sun.png",
                              value: "${data!.maxtemp}-${data!.temp}°C",
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            DescContainer(
                              txt: "Humidity",
                              image: "assets/images/icons8-water-100 1.png",
                              value: "${data!.maxhumid}-${data!.humid}°C",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Description",
                          style: kDescHeadingtxt.copyWith(fontSize: 22),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          data!.description!,
                          style: TextStyle(
                              color: Color(0xff404040),
                              fontSize: 13,
                              fontFamily: 'Mada',
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isloading = true;
                            });
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            cook = sharedPreferences.getString('cookie');
                            print(cook);
                            if (!widget.iszen!) {
                              var response = await _session.post(
                                  "https://sprout-plant-care-app.herokuapp.com/plant/${data!.id}",
                                  {"cookie": cook!.substring(4)});
                              print(response['message']);
                              if (response['message'] == "Plant saved") {
                                setState(() {
                                  isloading = false;
                                  Navigator.push(
                                      context, CustomRoute(child: ZenGarden()));
                                });
                              } else {
                                setState(() {
                                  isselected = false;
                                });
                                _fToast!.showToast(
                                    child: customToast(
                                      txt: response['message'],
                                    ),
                                    toastDuration: Duration(seconds: 2),
                                    gravity: ToastGravity.BOTTOM);
                              }
                            } else {
                              var response = await http.delete(
                                  Uri.parse(
                                      "https://sprout-plant-care-app.herokuapp.com/profile/mygarden/${data!.id}"),
                                  body: {"cookie": cook!.substring(4)});
                              setState(() {
                                isloading = false;
                                Navigator.push(
                                    context, CustomRoute(child: ZenGarden()));
                                print(select!.isselected);
                              });
                              print(response.body);
                              // if (res['message'] == "Plant saved") {
                              //   setState(() {
                              //   isloading = true;
                              //   Navigator.push(
                              //       context, CustomRoute(child: ZenGarden()));
                              //   });
                              // } else {
                              //   setState(() {
                              //     isselected = false;
                              //   });
                              //   _fToast!.showToast(
                              //       child: customToast(
                              //         txt: res['message'],
                              //       ),
                              //       toastDuration: Duration(seconds: 2),
                              //       gravity: ToastGravity.BOTTOM);
                              // }
                            }
                          },
                          child: AddPlant(
                            select: isselected,
                            iszengarden: widget.iszen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          )
        : Center(
            child: CircularProgressIndicator(
            backgroundColor: Color(0xffFCFFF6),
            color: kPrimaryColor,
          ));
  }
}

class AddPlant extends StatelessWidget {
  bool? select;
  bool? iszengarden;
  AddPlant({this.select, this.iszengarden});

  @override
  Widget build(BuildContext context) {
    return iszengarden!
        ? Container(
            height: 56,
            width: 380,
            decoration: BoxDecoration(
                color: select! ? kPrimaryColor : Color(0xff17bb0a),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              !select! ? "Remove" : "Removed",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  decoration: TextDecoration.none),
            )),
          )
        : Container(
            height: 56,
            width: 380,
            decoration: BoxDecoration(
                color: select! ? kPrimaryColor : Color(0xff17bb0a),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              !select! ? "Add to my zen garden" : "Saved",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  decoration: TextDecoration.none),
            )),
          );
  }
}

class DescContainer extends StatelessWidget {
  final String? image;
  final String? value;
  final String? txt;
  DescContainer({this.image, this.value, this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 170,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.15),
                blurRadius: 3,
                offset: Offset(1, 1))
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xffddffda),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image(image: AssetImage(image!)),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txt!,
                style: TextStyle(
                    color: Color(0xff17bb0a),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Mada",
                    decoration: TextDecoration.none),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                value!,
                style: kDescNametxt,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
