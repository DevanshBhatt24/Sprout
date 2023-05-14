import 'dart:developer';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constant.dart';

enum MenuItem { item1, item2 }

class CartItems extends StatefulWidget {
  const CartItems({Key? key}) : super(key: key);

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
        height: 110,
        width: 390,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff000000).withOpacity(.25), blurRadius: 4)
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
                    image: NetworkImage(
                        'https://images.pexels.com/photos/2736497/pexels-photo-2736497.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')),
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
                  PopupMenuItem(value: MenuItem.item1, child: Text('Item 1')),
                  PopupMenuItem(value: MenuItem.item2, child: Text('Item 2')),
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
                  Text('Monstera',
                      style: kHeadingtxt.copyWith(fontWeight: FontWeight.w600)),
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
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                side: BorderSide(
                                    color: Color(0xff49a010), width: 1)),
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
                        '$_counter',
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
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                side: BorderSide(
                                    color: Color(0xff49a010), width: 1)),
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
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
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
                      '200',
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
          ],
        ),
      ),
    );
  }
}
