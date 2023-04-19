import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/Login/login_screen.dart';
import 'package:novel_flutter/screens/Signup/signup_screen.dart';
import 'package:novel_flutter/screens/details_page.dart';
import 'package:novel_flutter/screens/home_page.dart';
import 'package:novel_flutter/screens/trending_page.dart';

import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomePage());
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case "/sign-up":
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case "/trending":
        return MaterialPageRoute(builder: (_) => TrendingPage());
    }
  }
}
