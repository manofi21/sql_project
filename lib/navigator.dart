import 'package:flutter/material.dart';

class ProjectNavigator {
  void withAnimation(BuildContext context, dynamic pages) {
    Navigator.of(context).push(
      PageRouteBuilder(
        fullscreenDialog: false,
        transitionDuration: Duration(seconds: 2),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return pages;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return FadeTransition(
            alwaysIncludeSemantics: true,
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void withOutAnimation(BuildContext context, dynamic pages) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: (BuildContext context) => pages));
  }
}
