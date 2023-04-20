import 'package:flutter/material.dart';
import 'package:novel_flutter/widget/trending_item_widget.dart';

import '../components/background.dart';
import '../widget/header_widget.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
        child: ListView(
      children: const [
        HeaderWidget(),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Trending now",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TrendingItemWidget(),
      ],
    ));
  }
}
