import 'package:Sprout/components/constant.dart';
import 'package:Sprout/components/customroute.dart';
import 'package:Sprout/screens/shop/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderSucess extends StatelessWidget {
  const OrderSucess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: h,
              width: w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Order-placed.png'),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            top: 170,
            left: 30,
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: h / 20, horizontal: w / 14),
              height: h / 1.6,
              width: w / 1.18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white),
              child: Column(children: [
                Container(
                  height: h / 7.0,
                  width: w / 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Color(0xff17bb0a).withOpacity(.3), width: 13)),
                  child: Icon(
                    FontAwesomeIcons.check,
                    color: kPrimaryColor,
                    size: 50,
                  ),
                ),
                SizedBox(
                  height: h / 26,
                ),
                Container(
                  width: w / 1.5,
                  height: h / 13,
                  child: Center(
                    child: Text(
                      'Order Successfully Placed',
                      textAlign: TextAlign.center,
                      style: ksucessBigText,
                    ),
                  ),
                ),
                SizedBox(
                  height: h / 30,
                ),
                Container(
                  width: w / 1.5,
                  height: h / 18,
                  child: Text(
                    'Your payment was successfull Just wait for your plants at home',
                    textAlign: TextAlign.center,
                    style: ksucessSmallText,
                  ),
                ),
                SizedBox(
                  height: h / 20,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .push(CustomRoute(builder: (context) => Shop())),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: w / 10.2, vertical: h / 62),
                    height: h / 16,
                    width: w / 1.5,
                    decoration: kplaceOrderButton,
                    child: Text(
                      'Continue Shopping',
                      style: kOrderText.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: h / 36,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .push(CustomRoute(builder: (context) => Shop())),
                  child: Text(
                    'Go to orders',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xff888888),
                        fontSize: 14),
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
