import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/Add_Novel/add_novel_screen.dart';
import 'package:novel_flutter/screens/Admin/admin_screen.dart';
import 'package:novel_flutter/screens/Admin/request_management_screen.dart';
import 'package:novel_flutter/screens/Admin/user_management_screen.dart';
import 'package:novel_flutter/screens/Bookmark/bookmark_screen.dart';
import 'package:novel_flutter/screens/Login/login_screen.dart';
import 'package:novel_flutter/screens/Signup/signup_screen.dart';
import 'package:novel_flutter/screens/Uploaded_Novels/upload_novels_screen.dart';
import 'package:novel_flutter/screens/Welcome/welcome_screen.dart';

import 'package:novel_flutter/screens/trending_page.dart';
import '../screens/Add_Chapter/add_chappter_screen.dart';
import '../screens/Home/home_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomePage());
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case "/sign-up":
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case "/trending":
        return MaterialPageRoute(builder: (_) => const TrendingPage());
      case "/uploaded":
        return MaterialPageRoute(builder: (_) => const UploadNovelScreen());
      case "/bookmarked":
        return MaterialPageRoute(builder: (_) => const BookmarkScreen());
      case "/add-chapter":
        return MaterialPageRoute(builder: (_) => const AddChapterScreen());
      case "/admin":
        return MaterialPageRoute(builder: (_) => const AdminScreen());
      case "/welcome":
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case "/add-novel":
        return MaterialPageRoute(builder: (_) => const AddNovelScreen());
      case "/rq-manage":
        return MaterialPageRoute(
            builder: (_) => const RequestManagementScreen());
      case "/user-manage":
        return MaterialPageRoute(builder: (_) => const UserManagementScreen());
    }
    return null;
  }
}
