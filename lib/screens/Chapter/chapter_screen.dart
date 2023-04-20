import 'package:flutter/material.dart';

import 'package:novel_flutter/screens/Chapter/components/chapter_bar.dart';

import '../../components/background.dart';

const String exampleNovel =
    'Một anh chàng có vai trò là một người quản lí trong một nhóm mạo hiểm giả, ■■■■■, đã bị phản bội bởi chính những thành viên trong nhóm của anh ta ở ngọn núi Kuguse, nơi có một con rồng đang cư ngụ. Dính một vết thương chí mạng rồi ngất đi, anh ta tỉnh lại trong tổ của Hỏa Long Kafal, nó đã mất đi quả trứng của mình trong một tai nạn. Vì một lí do nào đó, anh trở thành một cô bé và được ban cho cái tên Lucella, tên của cô con gái đã chết của con rồng sau khi anh đã mất đi toàn bộ kí ức của mình cùng với cái tên cũ. Có vẻ như Kafal sẽ nuôi nấng anh chàng như con gái của mình…? Đây là một câu chuyện kể về vận mệnh đã đưa một con rồng cùng với một con người đến với nhau như thế nào.';

class ChapterScreen extends StatelessWidget {
  ChapterScreen(this.chapter_number, {Key? key}) : super(key: key);
  int chapter_number;
  // @override
  // State<ChapterScreen> createState() => _ChapterScreenState();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return [
              ChapterBar(),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Text('Chapter: ${chapter_number}',
                      style: TextStyle(fontSize: 22)),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Độ dài: 2910 từ', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 5),
                      Text('Lần cuối cập nhật: 2020',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(exampleNovel, style: TextStyle(fontSize: 18)),
                  SizedBox(height: 5),
                  Text(exampleNovel, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
