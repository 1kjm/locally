import 'package:flutter/material.dart';

class NavigationAnimation {
  final pageRouteName;
  NavigationAnimation({required this.pageRouteName});
  Route createRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
          pageRouteName,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
