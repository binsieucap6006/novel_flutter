import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/screens/Chapter/chapter_screen.dart';
import 'package:novel_flutter/screens/Home/components/appbar_widget.dart';

import '../../Home/home_page.dart';

// const List<String> list = <String>[
//   'List chapter',
//   'Chapter One',
//   'Chapter Two',
//   'Chapter Three',
//   'Chapter Four'
// ];

class ChapterBar extends StatefulWidget implements PreferredSizeWidget {
  ChapterBar({required this.chapterNumber, required this.novelId, super.key});
  int chapterNumber;
  final String novelId;
  @override
  State<ChapterBar> createState() => _ChapterBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChapterBarState extends State<ChapterBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SimpleAppBarPage(),
            ),
          );
        },
        icon: const Icon(Icons.home),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          if (widget.chapterNumber > 1) {
            widget.chapterNumber = widget.chapterNumber - 1;
            int currentChap = widget.chapterNumber;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChapterScreen(currentChap, widget.novelId)),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChapterScreen(1, widget.novelId)),
            );
          }
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_forward_ios),
        )
      ],
      backgroundColor: kPrimaryColor,
      // backgroundColor: Colors.transparent,
    );
  }
}

// class DropdownChapterButton extends StatefulWidget {
//   const DropdownChapterButton({super.key});

//   @override
//   State<DropdownChapterButton> createState() => _DropdownChapterButtonState();
// }

// class _DropdownChapterButtonState extends State<DropdownChapterButton> {
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       dropdownColor: Colors.purple[700],
//       elevation: 16,
//       style: const TextStyle(color: Colors.white, fontSize: 20),
//       underline: Container(
//         height: 2,
//         color: Colors.white,
//       ),
//       onChanged: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
