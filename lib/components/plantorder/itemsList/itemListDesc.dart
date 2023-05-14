import 'package:Sprout/components/constant.dart';
import 'package:Sprout/components/plantorder/itemsList/review.dart';
import 'package:Sprout/components/plantorder/orderbutton/orderbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expandable_text/expandable_text.dart';

class ItemsListDesc extends StatelessWidget {
  String? name;
  String? price;
  String? image;
  String? category;
  String? desc;

  ItemsListDesc({this.name, this.price, this.category, this.desc});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name!,
              style: TextStyle(
                  color: Color(0xff303030),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: Color(0xff323232),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          category!,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Mada',
                              fontSize: 9),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      height: 22,
                      child: Row(children: [
                        Text(
                          '4.5',
                          style: TextStyle(
                              color: Color(0xff49A010),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Image(
                          image: AssetImage(
                              "assets/images/leaf-svgrepo-com 10.png"),
                          height: 18,
                          width: 18,
                        )
                      ]),
                    ),
                  ],
                ),
                Container(
                  width: 92,
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.indianRupeeSign,
                        color: Colors.white,
                        size: 16,
                      ),
                      Text(
                        price!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Description',
              style: TextStyle(
                  color: Color(0xff4b4b4b),
                  fontSize: 19,
                  fontFamily: 'Mada',
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            ExpandableText(
              desc!,
              style: TextStyle(
                  color: Color(0xff404040),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400),
              expandText: 'Read more',
              collapseText: 'Read less',
              linkStyle: TextStyle(
                  color: Color(0xff484b55),
                  fontSize: 15,
                  fontFamily: 'Mada',
                  fontWeight: FontWeight.w700),
              maxLines: 4,
              animation: true,
              animationDuration: Duration(milliseconds: 150),
              animationCurve: Curves.easeInOut,
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              color: Color(0xffd6d6d6),
              thickness: 1,
              indent: 5,
              endIndent: 8,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [BuyButton(), CartButton()],
            ),
            SizedBox(
              height: 30,
            ),
            Reviews()
          ],
        ),
      ),
    );
  }
}
