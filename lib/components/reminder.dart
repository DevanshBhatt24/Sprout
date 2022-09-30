import 'package:Sprout/components/constant.dart';
import 'package:flutter/material.dart';

class Reminders extends StatefulWidget {
  const Reminders({Key? key}) : super(key: key);

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  bool isselected = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 44,
            width: 325,
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(11)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isselected = true;
                  });
                },
                child: Container(
                  height: 34,
                  width: 150,
                  decoration: isselected
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.25),
                                blurRadius: 4,
                                offset: Offset(2, 1))
                          ],
                        )
                      : null,
                  child: Center(
                    child: Text(
                      "Reminders",
                      style: kLighttext.copyWith(
                          color: isselected ? kPrimaryColor : Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isselected = false;
                  });
                },
                child: Container(
                  height: 34,
                  width: 150,
                  decoration: !isselected
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.25),
                                  blurRadius: 4,
                                  offset: Offset(2, 1))
                            ])
                      : null,
                  child: Center(
                    child: Text("History",
                        style: kLighttext.copyWith(
                            color: isselected ? Colors.white : kPrimaryColor,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ]),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
