import 'package:Sprout/components/plantorder/itemsList/itemlist.dart';
import 'package:Sprout/screens/shop/Search/searchitem.dart';
import 'package:Sprout/services/name.dart';
import 'package:flutter/material.dart';

import '../../../components/constant.dart';

class SearchShop extends StatefulWidget {
  final String? data;

  SearchShop({this.data});

  @override
  State<SearchShop> createState() => _SearchShopState();
}

class _SearchShopState extends State<SearchShop> {
  // Session _session = Session();
  bool? isloading = true;
  apiFetcher _api = apiFetcher();
  List<shop>? desc;
  List? name;

  void Searchdata() async {
    desc = await _api.getShopItmes(widget.data!);
    print('isfav--${desc}');
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    isloading = true;
    Searchdata();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height) / 2.8;
    final double itemWidth = size.width / 2;
    // print(_session.getcookie());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfffcfff6),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(170), child: SearchItem()),
        body: !isloading!
            ? !desc!.isEmpty
                ? GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: itemWidth / itemHeight,
                    children: desc!
                        .map((val) => Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: ItemsList(
                                name: val.name,
                                category: val.category,
                                price: val.price.toString(),
                                image: val.img,
                                isfav: val.isfav,
                                isPlantdesc: false,
                              ),
                            ))
                        .toList())
                : Container(
                    child: Center(
                        child: Text(
                      'No Items',
                      style: kBigtext,
                    )),
                  )
            : Center(
                heightFactor: 16,
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xffFCFFF6),
                  color: kPrimaryColor,
                ),
              ));
  }
}
