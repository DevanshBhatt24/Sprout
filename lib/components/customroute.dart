import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget? child;
  CustomRoute({required this.child})
      : super(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => child!,
        );

  Widget buildTranstions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }
}
