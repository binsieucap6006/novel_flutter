import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/Add_Novel/add_novel_screen.dart';
import 'package:novel_flutter/screens/Bookmark/bookmark_screen.dart';
import 'package:novel_flutter/screens/Home/components/navbar_widget.dart';
import 'package:novel_flutter/screens/Home/home_page.dart';
import 'package:novel_flutter/screens/trending_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Call'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
        ],
      ),
      body: Navigator(
        onGenerateRoute: (settings) {
          Widget page = HomePage();
          if (settings.name == 'page2') page = AddNovelScreen();
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
    );
  }
}
