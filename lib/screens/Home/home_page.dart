import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/states/current_user.dart';

import '../../components/background.dart';
import '../../constants.dart';
import '../../routes/routes.dart';
import 'components/bottom_navbar.dart';
import 'components/header_widget.dart';
import 'components/latest_widget.dart';
import 'components/navbar_widget.dart';
import 'components/trending_bar_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final User? user = CurrentUser().currentUser;
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: ListView(
        children: [
          const NavBar(),

          const HeaderWidget(),
          //const SubMenuWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            // child: Text(
            //   "Trending",
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 20,
            //   ),
            // ),
            child: Row(
              children: [
                const Text(
                  "Trending",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(width: 250),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.TRENDING);
                  },
                  child: const Text(
                    'More',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const TrendingNovelWidget(),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Latest",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: kPrimaryColor,
              ),
            ),
          ),
          LatestNovelWidget(),
        ],
      ),
    );
  }
}
