import 'dart:convert';

import 'package:Sprout/services/session.dart';
import 'package:Sprout/main.dart';
import 'package:Sprout/screens/resetpass.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../components/customroute.dart';
import '../screens/signup.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Sprout/components/acoountcheck.dart';
import '../components/button.dart';
import '../components/constant.dart';
import '../components/customtoast.dart';
import '../components/googleuttons.dart';
import '../components/textcontain.dart';
import 'homescreen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class Cookie with ChangeNotifier, DiagnosticableTreeMixin {
  bool? isselected = false;
  void toggle(bool? selected) {
    isselected = selected!;
    notifyListeners();
  }
}

class _LogInState extends State<LogIn> {
  // final _auth = FirebaseAuth.instance;
  String? password;
  String? email;
  bool isloading = false;
  bool showtext = false;
  String? cookie;
  FToast? _fToast;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _fToast = FToast();
    _fToast!.init(context);
  }

  Session _session = Session();
  posturl(String email, String pass) async {
    Map data = {
      'email': email,
      'password': pass,
    };
    if (_formkey.currentState!.validate()) {
      var response = await _session.post(
          "https://sprout-plant-care-app.herokuapp.com/user/login", data);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var jsondata = null;
      if (response['message'] == 'Login successful') {
        jsondata = response;
        final cookies = Provider.of<Cookie>(context, listen: false);
        // print(jsondata['token']);
        setState(() {
          cookie = _session.getcookie();
          print(cookie);
          isloading = false;

          sharedPreferences.setString("token", jsondata['token']);
          sharedPreferences.setString("cookie", cookie!);

          Navigator.of(context).pushAndRemoveUntil(
              CustomRoute(child: MainPage()), (Route<dynamic> route) => false);
        });

        // print(cookie);
      } else {
        Navigator.of(context).push(
          CustomRoute(child: LogIn()),
        );
        _fToast!.showToast(
            child: customToast(
              txt: "Incorrect Password and email",
            ),
            toastDuration: Duration(seconds: 2),
            gravity: ToastGravity.BOTTOM);
      }
    }
  }

  void pressed() {
    setState(() {
      showtext = !showtext;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: isloading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xffFCFFF6),
                color: kPrimaryColor,
              ),
            )
          : Container(
              margin: EdgeInsets.fromLTRB(16, 10, 16, 62),
              color: Colors.white,
              child: Stack(children: [
                Positioned(
                    top: 84,
                    left: 40,
                    child: Text(
                      "Welcome Back",
                      style: kBigtext,
                    )),
                Positioned(
                    top: 142,
                    left: 85,
                    child: Text(
                      "Please log in to continue",
                      style: ksmalltext,
                    )),
                Positioned(
                  top: 215,
                  child: Form(
                    key: _formkey,
                    child: Container(
                      height: 270,
                      width: 360,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'E-mail',
                              style:
                                  ksmalltext.copyWith(color: Color(0xff262626)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter e-mail";
                                }
                                if (RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                  return 'Enter a valid e-mail ';
                                } else
                                  return null;
                              },
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  fillColor: Color(0xfff3f3f3),
                                  filled: true,
                                  hintText: "Enter e-mail",
                                  hintStyle: kHintText),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Password',
                              style:
                                  ksmalltext.copyWith(color: Color(0xff262626)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                                autofocus: false,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return "Enter minimun 6 character";
                                  }
                                },
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: showtext,
                                decoration: dec.copyWith(
                                    hintText: "Enter your password",
                                    suffixIconColor: Color(0xff5b5b5b),
                                    suffixIcon: GestureDetector(
                                      onTap: pressed,
                                      child: Icon(
                                        showtext
                                            ? FontAwesomeIcons.solidEye
                                            : FontAwesomeIcons.eyeSlash,
                                        size: 20,
                                      ),
                                    ))),
                          ]),
                    ),
                  ),
                ),
                Positioned(
                    top: 485,
                    child: InkWell(
                      child: Container(
                        decoration: boxdecoration,
                        child: TextButton(
                            style: flatbutton,
                            onPressed: () {
                              setState(() {
                                isloading = true;
                              });
                              posturl(email!, password!);
                              // print(_session.getcookie());
                            },
                            child: Text(
                              "Sign In",
                              style: kSmalltext.copyWith(color: Colors.white),
                            )),
                      ),
                    )),
                Positioned(
                  top: 566,
                  left: 55,
                  child: Text("Forgot your password?", style: ksmalltext),
                ),
                Positioned(
                  top: 566,
                  left: 230,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, CustomRoute(child: Resetpass()));
                    },
                    child: Text("Reset",
                        style: ksmalltext.copyWith(
                            color: Color(0xff17bb0a),
                            decoration: TextDecoration.underline)),
                  ),
                ),
                Positioned(
                    top: 630,
                    left: 160,
                    child: Text(
                      "Or",
                      style: ksmalltext,
                    )),
                Positioned(
                  top: 685,
                  left: 35,
                  child: Text(
                    "Don't have any account?",
                    style: ksmalltext,
                  ),
                ),
                Positioned(
                  top: 685,
                  left: 220,
                  child: GestureDetector(
                    onTap: kMovenext,
                    child: Text("Create acoount",
                        style: ksmalltext.copyWith(
                            color: Color(0xff17bb0a),
                            decoration: TextDecoration.underline)),
                  ),
                ),
              ]),
            ),
    );
  }

  void kMovenext() {
    Navigator.push(context, CustomRoute(child: SignUp()));
  }

//   void sigin() async {
//     setState(() {
//       FocusScope.of(context).requestFocus(FocusNode());
//     });
//     try {
//       if (_formkey.currentState!.validate()) {
//         await _auth.signInWithEmailAndPassword(
//             email: email!, password: password!);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MainPage()),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       switch (e.code) {
//         case "user-not-found":
//         case "invalid-email":
//         case "wrong-password":
//           _fToast!.showToast(
//               child: customToast(
//                 txt: "Wrong email address or password.",
//               ),
//               toastDuration: Duration(milliseconds: 1000),
//               gravity: ToastGravity.BOTTOM);
//           break;
//       }
//     }
//   }
// }
}

final ButtonStyle flatbutton = TextButton.styleFrom(
    foregroundColor: kPrimaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    minimumSize: Size(350, 56));
