import 'package:flutter/material.dart';

import '../../Home/home_page.dart';

const List<String> list = <String>[
  'List chapter',
  'Chapter One',
  'Chapter Two',
  'Chapter Three',
  'Chapter Four'
];

class ChapterBar extends StatefulWidget with PreferredSizeWidget {
  const ChapterBar({Key? key}) : super(key: key);

  @override
  State<ChapterBar> createState() => _ChapterBarState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _ChapterBarState extends State<ChapterBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: const DropdownChapterButton(),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.home),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
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
          icon: const Icon(Icons.notifications),
        )
      ],
      backgroundColor: Colors.purpleAccent,
      // backgroundColor: Colors.transparent,
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DropdownChapterButton extends StatefulWidget {
  const DropdownChapterButton({super.key});

  @override
  State<DropdownChapterButton> createState() => _DropdownChapterButtonState();
}

class _DropdownChapterButtonState extends State<DropdownChapterButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      dropdownColor: Colors.purple[700],
      elevation: 16,
      style: const TextStyle(color: Colors.white, fontSize: 20),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
