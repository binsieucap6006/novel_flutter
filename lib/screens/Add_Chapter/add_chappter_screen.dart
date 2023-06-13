import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';
import '../../components/background.dart';

import 'components/add_chapter_input.dart';

class AddChapterScreen extends StatefulWidget {
  const AddChapterScreen(
      {super.key, required this.novelId, required this.novelName});
  final String novelId;
  final String novelName;
  @override
  State<AddChapterScreen> createState() => _AddChapterScreenState();
}

class _AddChapterScreenState extends State<AddChapterScreen> {
  int chapterNum = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      chapterNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NavBar(
          //   title: '',
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: kPrimaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          //UploadNovelList(),
          Padding(
            padding: const EdgeInsets.only(left: 150),
            child: Column(
              children: [
                const SizedBox(height: defaultPadding * 3),
                const Text(
                  'Add Chapter',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                const SizedBox(height: defaultPadding * 2),
                Text(
                  'for ${widget.novelName}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: defaultPadding * 2),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: ChapterInput(
              novelId: widget.novelId,
            ),
          )
        ],
      ),
    );
  }
}
