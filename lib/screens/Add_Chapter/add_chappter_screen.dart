import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/responsive.dart';
import '../../components/background.dart';
import '../../widget/header_widget.dart';
import '../../widget/navbar_widget.dart';
import '../details_page.dart';
import 'components/add_chapter_input.dart';

class AddChapterScreen extends StatelessWidget {
  const AddChapterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: ListView(
        children: [
          const NavBar(),
          SizedBox(
            height: 50,
          ),
          //UploadNovelList(),
          Padding(
            padding: EdgeInsets.all(1),
            child: Column(
              children: [
                const Text(
                  'Input text',
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
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: ChapterInput(),
          )
        ],
      ),
    );
  }
}
