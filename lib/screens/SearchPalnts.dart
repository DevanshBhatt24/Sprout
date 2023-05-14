import 'package:Sprout/screens/plantdescription.dart';
import 'package:Sprout/services/name.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/constant.dart';
import '../components/customroute.dart';
import '../components/searchbar.dart';
import '../services/session.dart';

class SearchPlant extends StatefulWidget {
  final String? data;

  SearchPlant({this.data});

  @override
  State<SearchPlant> createState() => _SearchPlantState();
}

class _SearchPlantState extends State<SearchPlant> {
  // Session _session = Session();

  apiFetcher _api = apiFetcher();
  Future<List<Name>>? desc;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    desc = _api.getplants(widget.data!);

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    // print(_session.getcookie());
    return Material(
        color: Color(0xfffcfff6),
        child: Container(
            margin: EdgeInsets.fromLTRB(16, 70, 16, 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
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
                  SearchWidget(
                    isSearch: true,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                widthFactor: 1.3,
                child: Text(
                  "Plant",
                  style: TextStyle(
                      fontFamily: 'Popins',
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: kPrimaryColor),
                ),
              ),
              FutureBuilder<List<Name>>(
                  future: desc,
                  builder: ((context, snapshot) {
                    List<Name>? data = snapshot.data;
                    return data != null
                        ? Material(
                            child: Container(
                              color: Color(0xfffcfff6),
                              height: MediaQuery.of(context).size.height / 1.4,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: ((context, index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                CustomRoute(
                                                    builder: (context) =>
                                                        PlantHomepage(
                                                          Data: data[index],
                                                          iszen: false,
                                                        )));
                                          },
                                          child: Container(
                                            height: 70,
                                            width: 310,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(.25),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 4)
                                                ]),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              data[index]
                                                                  .image!))),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      data[index].botname!,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff393939),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      width: 250,
                                                      height: 35,
                                                      child: Text(
                                                        data[0].description!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontFamily: 'Mada',
                                                            color: Color(
                                                                0xff505050),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ))))),
                            ),
                          )
                        : Center(
                            heightFactor: 16,
                            child: CircularProgressIndicator(
                              backgroundColor: Color(0xffFCFFF6),
                              color: kPrimaryColor,
                            ),
                          );
                  }))
            ])));
  }
}
