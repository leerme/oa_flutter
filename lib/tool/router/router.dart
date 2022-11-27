
import 'package:flutter/material.dart';
import 'package:teacher/demo/demo_page.dart';
import 'package:teacher/home/pages/home_page.dart';
import 'package:teacher/login/login_cover_page.dart';
import 'package:teacher/login/login_page.dart';
import 'package:teacher/mine/mine_page.dart';


class FBRouter{

  static final Map<String, WidgetBuilder> routers = {
    LoginCoverPage.routeName : (ctx) => LoginCoverPage(),
    MyHomePage.routeName : (ctx) => MyHomePage(),
    FBLoginPage.routeName : (ctx) => FBLoginPage(),
    MinePage.routeName : (ctx) => MinePage(),
    DemoPage.routeName : (ctx) => DemoPage(),
  };

  static final RouteFactory generateRoute = (settings) {
    if (settings.name == "  ") {
      return MaterialPageRoute(
          builder: (ctx) {
            return MyHomePage();
          }
      );
    }
    return null;
  };


  static final RouteFactory unKnownRoute = (settings) {
    return MaterialPageRoute(
        builder: (ctx) {
          return MyHomePage();
        }
    );
  };
}