import 'package:Sprout/services/session.dart';
import 'package:Sprout/services/name.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../components/blog.dart';
import '../components/day.dart';
import '../components/navbar.dart';
import '../components/reminder.dart';
import '../components/searchbar.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  apiFetcher api = apiFetcher();
  // Session _session = Session();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // api.getdata("rose");
  }

  @override
  Widget build(BuildContext context) {
    // print(_session.getcookie());
    return Material(
      color: Color(0xfffcfff6),
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 60, 16, 5),
          child: Stack(children: [
            Positioned(
              top: 10,
              left: 2,
              child: SearchWidget(
                isSearch: false,
              ),
            ),
            Positioned(top: 80, left: 2, child: Blog()),
            Positioned(top: 320, left: 15, child: Reminders()),
            Positioned(top: 375, left: 2, child: Day())
          ]),
        ),
      ),
    );
  }
}
