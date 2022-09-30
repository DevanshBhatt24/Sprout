import 'package:flutter/material.dart';
import 'constant.dart';

class Day extends StatefulWidget {
  const Day({Key? key}) : super(key: key);

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today",
          style: kSmalltext.copyWith(fontWeight: FontWeight.w600),
        ),
        Scroll()
      ],
    );
  }
}

class Scroll extends StatefulWidget {
  Scroll({
    Key? key,
  }) : super(key: key);

  @override
  State<Scroll> createState() => _ScrollState();
}

class _ScrollState extends State<Scroll> {
  List<Map<String, dynamic>> card = [
    {
      "color": Color(0xff24881b),
      "textcolor": Colors.white,
      "text": "Water Aloe Vera",
      "width": 50.0
    },
    {
      "color": Color(0xff24881b),
      "textcolor": Colors.white,
      "text": "Fertilize Monstera",
      "width": 35.0
    },
    {
      "color": Color(0xfff4f4f4),
      "textcolor": Color(0xff393939),
      "text": "Repot Aloe Vera",
      "width": 50.0
    },
    {
      "color": Color(0xfff4f4f4),
      "textcolor": Color(0xff393939),
      "text": "Repot Aloe Vera",
      "width": 50.0
    },
    {
      "color": Color(0xfff4f4f4),
      "textcolor": Color(0xff393939),
      "text": "Repot Aloe Vera",
      "width": 50.0
    }
  ] as List<Map<String, dynamic>>;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          height: 340,
          width: 356,
          child: ListView.builder(
              itemCount: card.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    onDismissed: (_) {
                      setState(() {
                        card.removeAt(index);
                      });
                    },
                    child: Description(
                      color: card[index]["color"],
                      txtcolor: card[index]["textcolor"],
                      txt: card[index]["text"],
                      width: card[index]["width"],
                    ),
                  ),
                );
              })),
        )
      ]),
    );
  }
}

class Description extends StatelessWidget {
  final Color? color;
  final Color? txtcolor;
  final String? txt;
  final double? width;
  Description({this.color, this.width, this.txtcolor, this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      height: 80,
      width: 355,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.25), blurRadius: 3)
          ]),
      child: Row(children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xffddffda),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Image(
                image: AssetImage("assets/images/icons8-water-100 1.png")),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txt!,
                style: ksmalltext.copyWith(fontSize: 20, color: txtcolor),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "250ml",
                style: ksmalltext.copyWith(color: txtcolor, fontSize: 13),
              )
            ],
          ),
        ),
        SizedBox(
          width: width,
        ),
        Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/1623959191-medium-plant-dieffenbachia-white-pot_2048x.jpg"),
                    fit: BoxFit.cover))),
      ]),
    );
  }
}
