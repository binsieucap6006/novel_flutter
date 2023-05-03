import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/Chapter/chapter_screen.dart';

import '../../components/background.dart';
import '../../constants.dart';

class AddNovelScreen extends StatelessWidget {
  AddNovelScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: Column(
                    children: [
                      const Text(
                        'Bookmarked',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      const SizedBox(height: defaultPadding * 2),
                      const SizedBox(height: defaultPadding * 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
