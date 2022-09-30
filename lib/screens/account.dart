import 'package:Sprout/components/constant.dart';
import 'package:Sprout/components/customroute.dart';
import 'package:Sprout/screens/lauchscreen.dart';
import 'package:Sprout/screens/loading.dart';
import 'package:Sprout/services/session.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Accountdetails extends StatefulWidget {
  const Accountdetails({Key? key}) : super(key: key);

  @override
  State<Accountdetails> createState() => _AccountdetailsState();
}

class _AccountdetailsState extends State<Accountdetails> {
  // final auth = FirebaseAuth.instance;
  Session _sess = Session();
  signout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? cook = sharedPreferences.getString('cookie');
    Map<String, String?>? data = {'cokkie': cook};
    var res = _sess.post(
        "https://sprout-plant-care-app.herokuapp.com/user/logout", data);
    print(res);
    sharedPreferences.clear();
    print(sharedPreferences.getString("cookie"));
    print(sharedPreferences.getString("token"));
    Navigator.push(context, CustomRoute(child: SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xfffcfff6),
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 70, 24, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Settings",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: kPrimaryColor),
          ),
          SizedBox(
            height: 42,
          ),
          Text(
            "Notification",
            style: kHeadingtxt,
          ),
          SizedBox(
            height: 18,
          ),
          Text("Care Reminder", style: kColortext),
          SizedBox(
            height: 16,
          ),
          Divider(
            color: Color(0xffc9c9c9),
            thickness: 1,
          ),
          SizedBox(
            height: 20,
          ),
          Timeday(
            txt: "Morning",
            time: "10:00",
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            color: Color(0xffc9c9c9),
            thickness: 1,
          ),
          SizedBox(
            height: 20,
          ),
          Timeday(
            txt: "Evening",
            time: "19:00",
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            color: Color(0xffc9c9c9),
            thickness: 1,
          ),
          SizedBox(
            height: 35,
          ),
          Text(
            "Info",
            style: kHeadingtxt,
          ),
          SizedBox(
            height: 18,
          ),
          Timedays(
            txt: "About us",
            width: 250,
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            color: Color(0xffc9c9c9),
            thickness: 1,
          ),
          SizedBox(
            height: 20,
          ),
          Timedays(
            txt: "Rate us",
            width: 259,
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            color: Color(0xffc9c9c9),
            thickness: 1,
          ),
          SizedBox(
            height: 20,
          ),
          Timedays(
            txt: "Log out",
            width: 259,
            onpress: signout,
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            color: Color(0xffc9c9c9),
            thickness: 1,
          ),
        ]),
      ),
    );
  }
}

class Timeday extends StatelessWidget {
  final String? txt;
  final String? time;

  Timeday({this.time, this.txt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(txt!, style: kColortext),
        SizedBox(
          width: 200,
        ),
        Text(
          time!,
          style: TextStyle(
              fontFamily: 'Mada',
              fontWeight: FontWeight.w600,
              color: Color(0xff393939),
              fontSize: 16),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          FontAwesomeIcons.angleRight,
          size: 15,
        )
      ],
    );
  }
}

class Timedays extends StatelessWidget {
  final String? txt;
  final double? width;
  Function()? onpress;
  Timedays({this.txt, this.width, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(onTap: onpress, child: Text(txt!, style: kColortext)),
        SizedBox(
          width: width,
        ),
        Icon(
          FontAwesomeIcons.angleRight,
          size: 15,
        )
      ],
    );
  }
}
