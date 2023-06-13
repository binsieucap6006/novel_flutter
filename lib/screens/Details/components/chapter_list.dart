import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/chapterModel.dart';
import '../../Chapter/chapter_screen.dart';

class ChapterList extends StatefulWidget {
  const ChapterList(this.chapter, this.novelId, {super.key});
  final ChapterModel chapter;
  final String novelId;
  @override
  State<ChapterList> createState() => _ChapterListState();
}

class _ChapterListState extends State<ChapterList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Chapter ${widget.chapter.chapterNumber}",
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 210),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChapterScreen(
                      widget.chapter.chapterNumber!, widget.novelId),
                ),
              );
            },
            child: const Text(
              'READ NOW',
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
