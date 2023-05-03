import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/Admin/admin_screen.dart';
import 'package:novel_flutter/screens/Bookmark/bookmark_screen.dart';

import 'package:novel_flutter/screens/Login/login_screen.dart';
import 'package:novel_flutter/screens/Signup/signup_screen.dart';
import 'package:novel_flutter/screens/Uploaded_Novels/upload_novels_screen.dart';
import 'package:novel_flutter/screens/details_page.dart';
import 'package:novel_flutter/screens/home_page.dart';
import 'package:novel_flutter/screens/trending_page.dart';

import '../screens/Add_Chapter/add_chappter_screen.dart';
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
      case "/uploaded":
        return MaterialPageRoute(builder: (_) => UploadNovelScreen());
      case "/bookmarked":
        return MaterialPageRoute(builder: (_) => BookmarkScreen());
      case "/add-chapter":
        return MaterialPageRoute(builder: (_) => AddChapterScreen());
      case "/admin":
        return MaterialPageRoute(builder: (_) => AdminScreen());
    }
  }
}
