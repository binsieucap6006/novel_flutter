import 'package:flutter/material.dart';
import 'package:novel_flutter/widget/header_widget.dart';
import 'package:novel_flutter/widget/navbar_widget.dart';
import 'package:novel_flutter/widget/trending_bar_widget.dart';

import '../components/background.dart';
import '../widget/latest_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 250),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/trending');
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
                fontSize: 20,
              ),
            ),
          ),
          const LatestNovelWidget(),
        ],
      ),
    );
  }
}
