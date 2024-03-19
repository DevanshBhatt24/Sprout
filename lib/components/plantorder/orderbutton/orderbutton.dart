import 'package:Sprout/components/customroute.dart';
import 'package:Sprout/components/plantorder/cart/shopcart.dart';
import 'package:Sprout/components/provider.dart';
import 'package:Sprout/services/name.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyButton extends StatefulWidget {
  final String? id;
  BuyButton({this.id});

  @override
  State<BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: (() => Navigator.of(context)
          .push(CustomRoute(builder: (context) => Cart()))),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        height: h / 15,
        width: w / 2.4,
        decoration: BoxDecoration(
            color: Color(0xfff5b95f),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          'Buy Now',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              fontSize: 18),
        ),
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  final String? id;
  CartButton({this.id});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  apiFetcher _api = apiFetcher();
  var response;
  bool cart = false;
  bool istap = false;
  void add() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String token = _pref.getString('token')!;
    Map<String, String>? data = {'auth-token': token};
    response = await _api.addCartItmes(widget.id, data);
    print(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    var data = Provider.of<UserProvider>(context, listen: false).items;

    data!.forEach((element) {
      if (element.productId == widget.id) cart = true;
    });
    print(cart);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: (() => {
            // print(value.cart),

            setState(() {
              istap = !istap;
            }),

            if (istap)
              {
                if (!cart)
                  {
                    add(),
                  }
                else
                  {
                    add(),
                    Fluttertoast.showToast(
                        msg:
                            "Item Already present in cart. Quantity increased by 1",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.redAccent.withOpacity(.5),
                        textColor: Colors.white,
                        fontSize: 16.0),
                  }
              }
            else
              {
                Navigator.of(context)
                    .push(CustomRoute(builder: (context) => Cart()))
              }
          }),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        height: h / 15,
        width: w / 2.4,
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffc4c4c4), width: 3),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          !istap ? 'Add To Cart' : 'Go To Cart',
          style: TextStyle(
              color: Color(0xff3d3d3d),
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              fontSize: 18),
        ),
      ),
    );
  }
}
