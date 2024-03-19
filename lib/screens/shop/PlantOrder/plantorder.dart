import 'package:Sprout/components/plantorder/itemsList/itemlist.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../components/plantorder/itemsList/itemListDesc.dart';
import '../../../components/plantorder/itemsList/review.dart';
import '../../../components/plantorder/orderbutton/orderbutton.dart';

class Plantorder extends StatelessWidget {
  String? image;
  String? name;
  String? price;
  String? category;
  bool? isfav;
  String? prodid;
  Plantorder(
      {this.image,
      this.category,
      this.name,
      this.price,
      this.isfav,
      this.prodid});
  @override
  Widget build(BuildContext context) {
    print(prodid);
    double h = MediaQuery.of(context).size.height;
    ScrollController _controller = ScrollController(initialScrollOffset: h);
    // _controller.animateTo(
    //   100.0, // the offset to which to scroll
    //   duration: Duration(milliseconds: 500), // the duration of the animation
    //   curve: Curves.easeInOut, // the curve to use for the animation
    // );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfffcfff6),
      body: SingleChildScrollView(
        reverse: true,
        controller: _controller,
        child: Container(
          color: Color(0xfffcfff6),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              fit: BoxFit.fill, image: NetworkImage(image!))),
                      height: 500,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 16,
                    child: InkWell(
                      onTap: () {
                        print('tapped');
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.angleLeft,
                            color: Color(0xff494949),
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.solidHeart,
                          color: isfav! ? Color(0xff496a5b) : Color(0xff494949),
                          size: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ItemsListDesc(
                name: name,
                price: price,
                category: category,
                desc:
                    'Calatheas need specific care in order to thrive. They need a consistently warm spot and bright but indirect light – keep them out of direct sunshine. Keep the soil moist from spring to autumn, and provide some humidity by misting the leaves daily or..',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [BuyButton(id: prodid), CartButton(id: prodid)],
              ),
              SizedBox(
                height: 30,
              ),
              Reviews(),
              Padding(
                padding: EdgeInsets.all(16),
                child: Divider(
                  color: Color(0xffd6d6d6),
                  thickness: 1,
                  indent: 5,
                  endIndent: 8,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Similar Products',
                  style: TextStyle(
                      color: Color(0xff4b4b4b),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Mada',
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                child: Container(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    itemBuilder: (context, index) => ItemsList(
                      name: 'Corton Petra',
                      price: '200',
                      category: 'Outdoor',
                      image:
                          'https://img.freepik.com/premium-photo/codiaeum-iceton-croton-white-pot_267395-443.jpg?w=740',
                      isfav: false,
                      isPlantdesc: true,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom / 2)),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, h - 70);
    path.quadraticBezierTo(w * 0.5, h, w, h - 70);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
