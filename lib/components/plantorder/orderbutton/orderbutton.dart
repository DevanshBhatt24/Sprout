import 'package:Sprout/components/customroute.dart';
import 'package:Sprout/components/plantorder/cart/shopcart.dart';
import 'package:flutter/material.dart';

class BuyButton extends StatefulWidget {
  const BuyButton({Key? key}) : super(key: key);

  @override
  State<BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: (() => Navigator.of(context)
          .push(CustomRoute(builder: (context) => Cart()))),
      child: Container(
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
  const CartButton({Key? key}) : super(key: key);

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool? isCart = false;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: (() => setState(() {
            isCart = !isCart!;
          })),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        height: h / 15,
        width: w / 2.4,
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffc4c4c4), width: 3),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          !isCart! ? 'Add To Cart' : 'Item Added',
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
