import 'package:Sprout/components/constant.dart';
import 'package:Sprout/components/customroute.dart';
import 'package:Sprout/components/plantorder/cart/cartItems.dart';
import 'package:Sprout/components/plantorder/itemsList/itemlist.dart';
import 'package:Sprout/components/plantorder/orderplaced/ordersuccess.dart';
import 'package:Sprout/components/provider.dart';
import 'package:Sprout/screens/shop/shop.dart';
import 'package:Sprout/services/name.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/name.dart';

enum MenuItem { item1, item2, item3 }

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late Razorpay _razorpay;
  double total = 0;
  double? subtotal;
  late cartModel cart;
  late List<Product> prod;
  bool isloading = false;
  apiFetcher _api = apiFetcher();

  void items() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String token = _pref.getString('token')!;
    Map<String, String>? data = {'auth-token': token};
    cart = await _api.getCartItmes(data);
    if (cart.items != null) {
      prod = cart.items!.map((val) => Product.fromJson(val)).toList();
      Provider.of<UserProvider>(context, listen: false).setItems(prod);
      for (var i = 0; i < prod.length; i++) {
        double price = prod[i].price! * prod[i].quantity!.toDouble();
        total = total + price;
      }
      Provider.of<UserProvider>(context, listen: false).setPrice(total);
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    isloading = true;
    items();

    setState(() {
      Provider.of<UserProvider>(context, listen: false).price = subtotal;
      Provider.of<UserProvider>(context, listen: false).totalprice = total;
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popAndPushNamed('/shop');
        return true;
      },
      child: Scaffold(
          backgroundColor: Color(0xfffcfff6),
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size(0, 96),
            child: Padding(
              padding: EdgeInsets.fromLTRB(14, 24, 10, 0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: EdgeInsets.only(bottom: 6, top: 6),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xff17bb0a).withOpacity(.13),
                    child: InkWell(
                      onTap: () => Navigator.of(context)
                          .push(CustomRoute(builder: (context) => Shop())),
                      child: FaIcon(
                        FontAwesomeIcons.angleLeft,
                        color: Color(0xff494949),
                        size: 22,
                      ),
                    ),
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: Text(
                    'My Cart',
                    style: kbigtext,
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: PopupMenuButton<MenuItem>(
                      icon: Icon(
                        FontAwesomeIcons.ellipsisVertical,
                        color: kPrimaryColor,
                      ),
                      onSelected: (value) {
                        if (value == MenuItem.item1) {
                        } else if (value == MenuItem.item2) {
                        } else {}
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: MenuItem.item1, child: Text('Item 1')),
                        PopupMenuItem(
                            value: MenuItem.item2, child: Text('Item 2')),
                        PopupMenuItem(
                            value: MenuItem.item3, child: Text('Item 3')),
                      ],
                      color: Color(0xfffcfff6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: isloading
              ? Container(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  )),
                )
              : Consumer<UserProvider>(
                  builder: (context, value, child) {
                    double price = value.totalprice!.toDouble() + 20.0;
                    return value.items!.isEmpty
                        ? Container(
                            child: Center(
                                child: Text(
                              'Cart Empty!',
                              style: kbigtext,
                            )),
                          )
                        : Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: h / 1.8,
                                  margin: EdgeInsets.fromLTRB(0, 130, 0, 10),
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 2,
                                          left: 14,
                                          right: 16),
                                      scrollDirection: Axis.vertical,
                                      itemCount: value.items!.length,
                                      itemBuilder: (context, index) => Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 16, left: 3, right: 2),
                                          child: CartItems(
                                            index: index,
                                            cartid: cart.cartid,
                                            itemid: value.items![index].itemId,
                                            image: value.items![index].image,
                                            price: value.items![index].price,
                                            name: value.items![index].name,
                                            quantity:
                                                value.items![index].quantity,
                                          ))),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 4,
                                left: 4,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  height: h / 3.3,
                                  width: w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(.11),
                                            blurRadius: 11,
                                            offset: Offset(0, -4))
                                      ]),
                                  child: value.isloading!
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: kPrimaryColor,
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Subtotal:',
                                                  style: kcartText,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .indianRupeeSign,
                                                      size: 14,
                                                      color: kPrimaryColor,
                                                    ),
                                                    Text(
                                                      value.totalprice
                                                          .toString(),
                                                      style: kcartText,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Shipping Cost:',
                                                  style: kcartText,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .indianRupeeSign,
                                                      size: 14,
                                                      color: kPrimaryColor,
                                                    ),
                                                    Text(
                                                      '20',
                                                      style: kcartText,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Divider(
                                              color: Color(0xffe0e0e0),
                                              thickness: 1,
                                              indent: 5,
                                              endIndent: 5,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total:',
                                                  style: ktotalText,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .indianRupeeSign,
                                                      size: 15,
                                                      color: kPrimaryColor,
                                                    ),
                                                    Text(
                                                      price.toString(),
                                                      style: ktotalText,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 24,
                                            ),
                                            InkWell(
                                              onTap: () => {checkout()},
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: w / 4.2,
                                                    vertical: h / 62),
                                                height: h / 16,
                                                width: w,
                                                decoration: kplaceOrderButton,
                                                child: Text(
                                                  'Place Your Order',
                                                  style: kOrderText,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                              )
                            ],
                          );
                  },
                )),
    );
  }

  void checkout() async {
    var options = {
      'key': 'rzp_test_tx6YFzmcUEYfrS',
      'amount': total.toString(),
      'name': 'SPROUT',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': ' ', 'email': ' '}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response);
    Navigator.of(context)
        .push(CustomRoute(builder: (context) => OrderSucess()));
    Fluttertoast.showToast(
        msg: "Success: " + response.paymentId!,
        timeInSecForIosWeb: 4,
        backgroundColor: Color(0xff49a010),
        textColor: Colors.white);
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Error: " + response.code.toString() + " - " + response.message!,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white);

    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "Success: " + response.walletName!,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white);

    // Do something when an external wallet was selected
  }
}
