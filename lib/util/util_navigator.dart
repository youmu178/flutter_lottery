import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtil {
  static void pushPage(BuildContext context, Widget page) {
    if (context == null || page == null) return;
    Navigator.push(context, CupertinoPageRoute<void>(builder: (BuildContext context) => page));
  }

  static void pushWithAnim(BuildContext context, Widget page) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (BuildContext context, _, __) {
              return page;
            },
            transitionsBuilder:
                (___, Animation<double> animation, ____, Widget child) {
              return SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: const Offset(0.0, 0.0))
                      .animate(animation),
                  child: child,
              );
            }));
  }
}
