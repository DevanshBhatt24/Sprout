import 'package:Sprout/screens/shop/PlantOrder/plantorder.dart';
import 'package:Sprout/services/name.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../components/constant.dart';
import '../../../components/customroute.dart';
import '../../../components/plantorder/itemsList/itemlist.dart';

class AllPlants extends StatefulWidget {
  final order? shopplant;
  const AllPlants({this.shopplant});

  @override
  State<AllPlants> createState() => _AllPlantsState();
}

class _AllPlantsState extends State<AllPlants> {
  apiFetcher _apidata = apiFetcher();
  List<shop>? Or;
  bool? isloading = false;
  List? favrouite = [true, false, false, false, false];
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void orderdata() async {
    Or = await _apidata.getshopdata();
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    isloading = true;
    orderdata();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return isloading!
        ? Container(
            child: Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            )),
          )
        : Or == null
            ? Container(
                child: Center(
                    child: Text(
                  'No Data',
                  style: kBigtext,
                )),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Popular",
                      style: kSmalltext.copyWith(
                          color: Color(0xff303030),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          itemCount: Or!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ItemsList(
                                isPlantdesc: false,
                                prodid: Or![index].id,
                                name: Or![index].name,
                                price: Or![index].price.toString(),
                                image: Or![index].img,
                                category: Or![index].category,
                                isfav: favrouite![index]);
                          }),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Recomended",
                      style: kSmalltext.copyWith(
                          color: Color(0xff303030),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          itemCount: Or!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: ItemsList(
                                isPlantdesc: false,
                                name: Or![index].name,
                                price: Or![index].price.toString(),
                                image: Or![index].img,
                                category: Or![index].category,
                                isfav: favrouite![index],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
  }
}
