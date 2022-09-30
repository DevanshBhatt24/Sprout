import 'package:Sprout/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/constant.dart';
import '../components/googleuttons.dart';

class Resetpass extends StatelessWidget {
  Resetpass({Key? key}) : super(key: key);
  final _formkey = GlobalKey<FormState>();
  String? email;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    void kMovenext() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
    }

    void resetpass() async {
      await _auth.sendPasswordResetEmail(email: email!).then((value) =>
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogIn())));
    }

    return Material(
        color: Colors.white,
        child: Container(
            margin: EdgeInsets.fromLTRB(16, 20, 16, 120),
            child: Stack(children: [
              Positioned(
                  top: 100,
                  left: 30,
                  child: Text(
                    "Did someone forgot\n \t\t\ttheir password?",
                    style: kBigtext.copyWith(fontSize: 28),
                  )),
              Positioned(
                  top: 220,
                  left: 50,
                  child: Text(
                    "Sign up to explore plants care guid.\n \t\t\t\t\tIt don’t take a lot of time.",
                    style: ksmalltext,
                  )),
              Positioned(
                top: 310,
                child: Text(
                  'E-mail',
                  style: ksmalltext.copyWith(color: Color(0xff262626)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Positioned(
                top: 345,
                child: Form(
                  key: _formkey,
                  child: Container(
                    height: 400,
                    width: 360,
                    child: TextFormField(
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
                  ),
                ),
              ),
              Positioned(
                  top: 450,
                  child: Button(
                    color: kPrimaryColor,
                    pressed: resetpass,
                    txtcolor: Colors.white,
                    txt: "Reset Password",
                    isboxdec: false,
                  )),
              Positioned(
                  top: 550,
                  left: 160,
                  child: Text(
                    "Or",
                    style: ksmalltext,
                  )),
              Positioned(
                  top: 600,
                  left: 70,
                  child: Row(
                    children: [
                      Buttons(),
                    ],
                  )),
              Positioned(
                top: 690,
                left: 50,
                child: Text(
                  "Remember the password?",
                  style: ksmalltext,
                ),
              ),
              Positioned(
                top: 690,
                left: 245,
                child: GestureDetector(
                  onTap: kMovenext,
                  child: Text("Log in",
                      style: ksmalltext.copyWith(
                          color: Color(0xff17bb0a),
                          decoration: TextDecoration.underline)),
                ),
              ),
            ])));
  }
}
