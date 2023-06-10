import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';
import '../../components/background.dart';

import '../Home/components/navbar_widget.dart';
import 'components/add_chapter_input.dart';

class AddChapterScreen extends StatelessWidget {
  const AddChapterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: ListView(
        children: [
          const NavBar(),
          const SizedBox(
            height: 50,
          ),
          //UploadNovelList(),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              children: const [
                Text(
                  'Input text',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                SizedBox(height: defaultPadding * 2),
                SizedBox(height: defaultPadding * 2),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: ChapterInput(),
          )
        ],
      ),
    );
  }
}
