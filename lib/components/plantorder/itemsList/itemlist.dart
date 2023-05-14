import 'package:Sprout/components/constant.dart';
import 'package:Sprout/screens/shop/PlantOrder/plantorder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../customroute.dart';

class ItemsList extends StatelessWidget {
  String? name;
  String? price;
  String? image;
  String? category;
  bool? isfav;
  bool? isPlantdesc;
  ItemsList(
      {this.name,
      this.price,
      this.category,
      this.image,
      this.isfav,
      this.isPlantdesc});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: (() =>
            Navigator.of(context).push(CustomRoute(builder: (context) {
              return Plantorder(
                image: image,
                price: price,
                name: name,
                category: category,
                isfav: isfav,
              );
            }))),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shopcard(
                image: image,
                isfav: isfav,
                isplantdesc: isPlantdesc,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name!,
                    style: TextStyle(
                        color: Color(0xff303030),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
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
                        image:
                            AssetImage("assets/images/leaf-svgrepo-com 10.png"),
                        height: 18,
                        width: 18,
                      )
                    ]),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
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
                        color: Colors.white, fontFamily: 'Mada', fontSize: 9),
                  ),
                ),
              ),
              SizedBox(
                height: 11,
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
        ),
      ),
    );
  }
}

class Shopcard extends StatelessWidget {
  final String? image;
  final bool? isfav;
  final bool? isplantdesc;
  const Shopcard({this.isfav, this.image, this.isplantdesc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 180,
      child: Stack(
        children: [
          Positioned(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(image!),
                height: 180,
                width: 180,
              ),
            ),
          ),
          isplantdesc!
              ? Container()
              : Positioned(
                  top: 0,
                  right: 10,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Image(
                          image: AssetImage('assets/images/Rectangle 556.png'),
                          height: 38,
                          width: 26,
                        ),
                      ),
                      Positioned(
                        top: 4.5,
                        left: 5,
                        child: isfav!
                            ? Image(
                                image: AssetImage('assets/images/heart.png'),
                                height: 14.6,
                                width: 16,
                              )
                            : Image(
                                image: AssetImage(
                                    'assets/images/uncolouredheart.png'),
                                height: 14,
                                width: 16,
                              ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
