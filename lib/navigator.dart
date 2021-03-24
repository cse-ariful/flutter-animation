import 'package:flutter/material.dart';

class Navigation {
  static Future<T> push<T>(BuildContext context, Widget page) async {
    return await Navigator.of(context)
        .push<T>(MaterialPageRoute(builder: (ctx) => page));
  }

  static Future<T> pushTransparent<T>(BuildContext context, Widget page) async {
    return await Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        opaque: false, // set to false
        pageBuilder: (_, __, ___) => page,
      ),
    );
  }

  static Future<T> pushWithFadeInEffect<T>(BuildContext context, Widget page) async {
    return await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => page,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }



  static void pop(BuildContext context) {
    return Navigator.of(context).pop();
  }
}
