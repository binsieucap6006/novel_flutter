import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/Add_Novel/add_novel_screen.dart';
import 'package:novel_flutter/screens/Login/login_screen.dart';
import 'package:novel_flutter/screens/Signup/signup_screen.dart';
import 'package:novel_flutter/screens/Uploaded_Novels/upload_novels_screen.dart';
import 'package:novel_flutter/screens/home_page.dart';
import 'package:novel_flutter/states/current_user.dart';

import 'Welcome/welcome_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CurrentUser().authStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AddNovelScreen();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
