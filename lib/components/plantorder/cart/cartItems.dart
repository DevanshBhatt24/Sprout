import 'dart:developer';

import 'package:Sprout/services/name.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../constant.dart';
import '../../provider.dart';

enum MenuItem { item1, item2 }

class CartItems extends StatefulWidget {
  int? quantity;
  int? index;
  final String? itemid;
  final String? cartid;
  final int? price;
  final String? name;
  final String? image;
  CartItems(
      {this.image,
      this.index,
      this.itemid,
      this.cartid,
      this.price,
      this.name,
      this.quantity});

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  int _counter = 1;
  apiFetcher _api = apiFetcher();
  late cartModel cart;
  late List<Product> prod;
  bool? isloading = false;
  void _incrementCounter() async {
    Provider.of<UserProvider>(context, listen: false).setLoading();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String token = _pref.getString('token')!;
    Map<String, String>? data = {'auth-token': token};
    var response = await _api.increaseItmes(widget.cartid, widget.itemid, data);
    cart = await _api.getCartItmes(data);
    prod = cart.items!.map((val) => Product.fromJson(val)).toList();
    Provider.of<UserProvider>(context, listen: false).setItems(prod);
    double price =
        prod[widget.index!].price! * prod[widget.index!].quantity!.toDouble();
    print(price);
    Provider.of<UserProvider>(context, listen: false).unsetLoading();

    // setState(() {
    //   // widget.quantity = widget.quantity! + 1;
    // });
  }

  void _decrementCounter() async {
    Provider.of<UserProvider>(context, listen: false).setLoading();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String token = _pref.getString('token')!;
    Map<String, String>? data = {'auth-token': token};
    var response = await _api.decreaseItmes(widget.cartid, widget.itemid, data);
    cart = await _api.getCartItmes(data);
    prod = cart.items!.map((val) => Product.fromJson(val)).toList();
    Provider.of<UserProvider>(context, listen: false).setItems(prod);
    print(response);
    Provider.of<UserProvider>(context, listen: false).unsetLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<UserProvider>(
        builder: (context, value, child) {
          return value.isloading!
              ? Shimmer.fromColors(
                  child: Container(
                    height: 110,
                    width: 390,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kPrimaryColor.withOpacity(.17),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: kPrimaryColor.withOpacity(.17),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 40,
                                  width: 220,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: kPrimaryColor.withOpacity(.17),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade300)
              : Container(
                  padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
                  height: 110,
                  width: 390,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff000000).withOpacity(.25),
                            blurRadius: 4)
                      ]),
                  child: Stack(
                    children: [
                      Positioned(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Image(
                              height: 84,
                              width: 84,
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.image!)),
                        ),
                      ),
                      Positioned(
                        top: -14,
                        right: -16,
                        child: PopupMenuButton<MenuItem>(
                          icon: ImageIcon(
                            AssetImage('assets/images/more-vertical.png'),
                            color: kPrimaryColor,
                          ),
                          onSelected: (value) {
                            if (value == MenuItem.item1) {
                            } else if (value == MenuItem.item2) {
                            } else {}
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: MenuItem.item1, child: Text('Remove')),
                            PopupMenuItem(
                                value: MenuItem.item2, child: Text('Item 2')),
                          ],
                          color: Color(0xfffcfff6),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name!,
                                style: kHeadingtxt.copyWith(
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "It's spine don't grow",
                              style: kDescLighttxt,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          side: BorderSide(
                                              color: Color(0xff49a010),
                                              width: 1)),
                                      onPressed: _decrementCounter,
                                      child: Icon(
                                        FontAwesomeIcons.minus,
                                        size: 8,
                                        color: Color(0xff49a010),
                                      )),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  widget.quantity.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Mada',
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff939393)),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          side: BorderSide(
                                              color: Color(0xff49a010),
                                              width: 1)),
                                      onPressed: _incrementCounter,
                                      child: Icon(
                                        FontAwesomeIcons.plus,
                                        size: 8,
                                        color: Color(0xff49a010),
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 85,
                          height: 32,
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.indianRupeeSign,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                Text(
                                  widget.price.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
