import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/models/chapterModel.dart';
import 'package:novel_flutter/models/novel_model.dart';

import '../../components/background.dart';
import '../../constants.dart';
import 'components/chapter_list.dart';

class DetailsPage extends StatefulWidget {
  // String name;
  // String genre;
  // String user;
  // String img;
  // String description;
  const DetailsPage(this.novel, {super.key});
  final NovelModel novel;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<Object> chapterList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getChapterList();
  }

  bool _isFavorited = false;
  void pressFavorite() {
    setState(() {
      if (_isFavorited) {
        delFavorite();
        _isFavorited = false;
      } else {
        addFavorite();
        _isFavorited = true;
      }
    });
  }

  //bool exist = false;
  bool checkExist() {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Bookmark')
          .doc(widget.novel.id)
          .get()
          .then((doc) {
        _isFavorited = doc.exists;
      });

      return _isFavorited;
    } catch (e) {
      setState(() {
        _isFavorited = false;
      });
      // If any error
      return _isFavorited = false;
    }
  }

  @override
  void initState() {
    super.initState();
    checkExist();
    //pressFavorite();
  }

  addFavorite() async {
    try {
      var dataRef = await FirebaseFirestore.instance.collection('Users');
      User? user = FirebaseAuth.instance.currentUser;
      var bookmark = dataRef
          .doc(user!.uid)
          .collection('Bookmark')
          .doc(widget.novel.id)
          .set(
        {
          'name': widget.novel.name,
          'id': widget.novel.id,
          'genre': widget.novel.genre,
          'description': widget.novel.description,
          'user': user.uid,
        },
      );
    } catch (e) {}
  }

  delFavorite() async {
    try {
      var dataRef = await FirebaseFirestore.instance.collection('Users');
      User? user = FirebaseAuth.instance.currentUser;
      var bookmark = dataRef
          .doc(user!.uid)
          .collection('Bookmark')
          .doc(widget.novel.id)
          .delete();
    } catch (e) {}
  }

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
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                //SizedBox(height: 10),
                Center(
                  child: Image.network(
                    widget.novel.image!,
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),
                ),

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        widget.novel.name!,
                        style: const TextStyle(
                            fontSize: 30,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const Text(
                            "Categories: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.novel.genre!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Description: ",
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        widget.novel.description!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 40),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          //Navigator.of(context).pushNamed(Routes.BOOKMARKED);
                          print(widget.novel.id);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: InkWell(
                            child: IconButton(
                              icon: (_isFavorited
                                  ? Icon(Icons.favorite, size: 40)
                                  : Icon(Icons.favorite_border, size: 40)),
                              onPressed: () {
                                pressFavorite();
                                print(_isFavorited);
                              },
                              // Icons.favorite_border,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 240),
                      //   child: Icon(
                      //     Icons.thumb_up,
                      //     size: 40,
                      //     color: kPrimaryColor,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 25, right: 40),
                  child: Text(
                    "Chapters",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 30),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: chapterList.length,
                  itemBuilder: (context, index) {
                    return ChapterList(
                        chapterList[index] as ChapterModel, widget.novel.id!);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   children: [
                //     Text(
                //       "Chapter ${i}",
                //       style: TextStyle(fontSize: 14),
                //     ),
                //     SizedBox(width: 300),
                //     Text(
                //       "READ NOW",
                //       style: TextStyle(fontSize: 14),
                //     ),
                //     SizedBox(height: 40),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getChapterList() async {
    //final uid = AuthService()
    var data = await FirebaseFirestore.instance
        .collection('Requests')
        .doc(widget.novel.id)
        .collection('Chapters')
        .get();
    setState(() {
      chapterList =
          List.from(data.docs.map((doc) => ChapterModel.fromSnapshot(doc)));
    });
  }
}
