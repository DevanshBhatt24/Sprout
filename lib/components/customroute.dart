import 'package:flutter/material.dart';

class CustomRoute extends MaterialPageRoute {
  CustomRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0), // starting position
        end: Offset.zero, // ending position
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      )),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);
}
