import 'dart:convert';
import 'dart:ui';
import 'package:Sprout/components/customroute.dart';
import 'package:Sprout/components/provider.dart';
import 'package:http/http.dart' as http;
import 'package:Sprout/main.dart';
import 'package:Sprout/screens/login.dart';
import 'package:provider/provider.dart';
import '../screens/signup.dart';
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
import '../services/session.dart';
import 'homescreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? password;
  String? password2;
  String? username;
  String? email;
  String? cookie;

  bool isloading = false;
  FToast? _fToast;
  bool showtext = true;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _fToast = FToast();
    _fToast!.init(context);
  }

  Session _session = Session();

  void posturl(String username, String email, String password) async {
    Map data = {'email': email, 'password': password, 'username': username};
    var response = await _session.post(
        "https://sprout-plant-care-app.onrender.com/user/register", data);
    // print(email);
    // print(username);
    // print(password);
    // print(response.statusCode);
    print(response);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MainPage()),
    // // );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsondata = null;

    // print(response['message']);
    if (response['message'] == "Register successful") {
      jsondata = response;

      Provider.of<UserProvider>(context, listen: false).setUser();
      setState(() {
        // cookie = _session.getcookie();
        // print(cookie);
        sharedPreferences.setString("token", jsondata['token']);
        print(sharedPreferences.getString("token"));

        // sharedPreferences.setString("cookie", cookie!);
        isloading = false;
        Navigator.of(context).push(
          CustomRoute(builder: (context) => MainPage()),
        );
      });
    } else {
      Navigator.of(context).push(
        CustomRoute(builder: (context) => SignUp()),
      );
      _fToast!.showToast(
          child: customToast(
            txt: "Email already in use",
          ),
          toastDuration: Duration(milliseconds: 2000),
          gravity: ToastGravity.BOTTOM);
    }
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
            ))
          : SingleChildScrollView(
              child: Container(
                height: size.height * 1.05,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(16, 100, 16, 100),
                child: Stack(children: [
                  Positioned(
                      top: 10,
                      left: 30,
                      child: Text(
                        "Create Account",
                        style: kBigtext,
                      )),
                  Positioned(
                      top: 70,
                      left: 50,
                      child: Text(
                        "Sign up to explore plants care guid.\n \t\t\t\t\t\t\t\t It don’t take a lot of time.",
                        style: ksmalltext,
                      )),
                  Positioned(
                    top: 155,
                    child: Form(
                      key: _formkey,
                      child: Container(
                        height: 550,
                        width: 360,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username',
                                style: ksmalltext.copyWith(
                                    color: Color(0xff262626)),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                autofocus: false,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Username";
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    username = value;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none),
                                    fillColor: Color(0xfff3f3f3),
                                    filled: true,
                                    hintText: "Enter username",
                                    hintStyle: kHintText),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'E-mail',
                                style: ksmalltext.copyWith(
                                    color: Color(0xff262626)),
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
                                  setState(() {
                                    email = value;
                                  });
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
                                height: 20,
                              ),
                              Text(
                                'Password',
                                style: ksmalltext.copyWith(
                                    color: Color(0xff262626)),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  autofocus: false,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.length < 6) {
                                      return "Enter minimun 6 character";
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
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
                                          size: 16,
                                        ),
                                      ))),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Re-enter Password',
                                style: ksmalltext.copyWith(
                                    color: Color(0xff262626)),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  autofocus: false,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value != password) {
                                      return "Those password doesn't match. Try again.";
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      password2 = value;
                                    });
                                  },
                                  obscureText: showtext,
                                  decoration: dec.copyWith(
                                      hintText: "Enter previous password",
                                      suffixIconColor: Color(0xff5b5b5b),
                                      suffixIcon: GestureDetector(
                                        onTap: pressed,
                                        child: Icon(
                                          showtext
                                              ? FontAwesomeIcons.solidEye
                                              : FontAwesomeIcons.eyeSlash,
                                          size: 16,
                                        ),
                                      ))),
                            ]),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 650,
                      child: InkWell(
                        child: Container(
                          decoration: boxdecoration,
                          child: TextButton(
                              style: flatbutton,
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  posturl(username!, email!, password!);
                                  setState(() {
                                    isloading = true;
                                  });
                                }
                              },
                              child: Text(
                                "Sign In",
                                style: kSmalltext.copyWith(color: Colors.white),
                              )),
                        ),
                      )),
                  Positioned(
                    top: 740,
                    left: 20,
                    child: Text("By registring, you agree to our",
                        style: ksmalltext),
                  ),
                  Positioned(
                    top: 740,
                    left: 240,
                    child: Text("Terms of use",
                        style: ksmalltext.copyWith(
                            color: Color(0xff17bb0a),
                            decoration: TextDecoration.underline)),
                  ),
                  Positioned(
                      top: 790,
                      left: 160,
                      child: Text(
                        "Or",
                        style: ksmalltext,
                      )),
                  Positioned(
                    top: 830,
                    left: 55,
                    child: Text(
                      "Already have account?",
                      style: ksmalltext,
                    ),
                  ),
                  Positioned(
                    top: 830,
                    left: 225,
                    child: GestureDetector(
                      onTap: kMovenext,
                      child: Text("Log In",
                          style: ksmalltext.copyWith(
                              color: Color(0xff17bb0a),
                              decoration: TextDecoration.underline)),
                    ),
                  ),
                ]),
              ),
            ),
    );
  }

  void kMovenext() {
    Navigator.of(context).push(CustomRoute(builder: (context) => LogIn()));
  }

//   void signup() async {
//     setState(() {
//       FocusScope.of(context).requestFocus(FocusNode());
//     });
//     try {
//       if (_formkey.currentState!.validate()) {
//         print(email);
//         print(password);
//         await _auth.createUserWithEmailAndPassword(
//             email: email!, password: password!);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MainPage()),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       switch (e.code) {
//         case "email-already-in-use":
//           _fToast!.showToast(
//               child: customToast(
//                 txt: "This e-mail id already registered.",
//               ),
//               gravity: ToastGravity.BOTTOM,
//               toastDuration: Duration(seconds: 1));
//       }
//     }
//   }

  void pressed() {
    setState(() {
      showtext = !showtext;
    });
  }
}

final ButtonStyle flatbutton = TextButton.styleFrom(
    backgroundColor: kPrimaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    minimumSize: Size(350, 56));
