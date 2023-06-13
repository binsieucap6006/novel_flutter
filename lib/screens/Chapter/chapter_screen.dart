// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';

import 'package:novel_flutter/screens/Chapter/components/chapter_bar.dart';

import '../../components/background.dart';

class ChapterScreen extends StatefulWidget {
  ChapterScreen(this.chapterNumber, this.novelId, {super.key});
  int chapterNumber;
  String novelId;
  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  // @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return [
              ChapterBar(
                chapterNumber: widget.chapterNumber,
                novelId: widget.novelId,
              ),
            ];
          },
          body: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("Requests")
                  .doc(widget.novelId)
                  .collection('Chapters')
                  .doc(widget.chapterNumber.toString())
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Chapter: ${widget.chapterNumber}',
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: const [
                          //     Text('Độ dài: 2910 từ', style: TextStyle(fontSize: 18)),
                          //     SizedBox(width: 5),
                          //     Text('Lần cuối cập nhật: 2020',
                          //         style: TextStyle(fontSize: 18)),
                          //   ],
                          // ),
                          const SizedBox(height: 20),

                          Text(
                            snapshot.data!['body']
                                .toString()
                                .replaceAll('.', '.\n'),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 5),
                          //Text(exampleNovel, style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          backgroundColor: kPrimaryColor,
                          color: Colors.white,
                        )),
                  );
                }
              }),
        ),
      ),
    );
  }
}
