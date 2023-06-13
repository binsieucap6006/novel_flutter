import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChapterInput extends StatefulWidget {
  const ChapterInput({super.key, required this.novelId});
  final String novelId;
  @override
  State<ChapterInput> createState() => _ChapterInputState();
}

class _ChapterInputState extends State<ChapterInput> {
  GlobalKey<FormState> key = GlobalKey();
  String novelId = '';
  final TextEditingController _chapterBodyController = TextEditingController();
  //String? selectedGenre = 'Action';
  // String imageUrl = '';
  // String rqID = '';
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getLastId();
    novelId = widget.novelId;
    // final CollectionReference _reference = FirebaseFirestore.instance
    //     .collection('Requests')
    //     .doc(novelId)
    //     .collection('Chapters');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  String getUID() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid!;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //final TextEditingController textcontroller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 400, // do it in both Container
          color: kPrimaryLightColor,
          padding: const EdgeInsets.all(5),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              // minWidth: _contextWidth(),
              // maxWidth: _contextWidth(),
              maxHeight: height, //when it reach the max it will use scroll
              maxWidth: width,
            ),
            child: TextField(
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.multiline,
              minLines: 10,
              maxLines: null, //grow automatically
              //focusNode: mrFocus,
              controller: _chapterBodyController,
              //onSubmitted: currentIsComposing ? _handleSubmitted : null,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Please enter a lot of text',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<Object>(
                future: getLastId(),
                builder: (context, snapshot) {
                  return ElevatedButton(
                    onPressed: () async {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Chapter added')));
                      //print(novelId);
                      String chapterBody = _chapterBodyController.text;
                      DocumentReference reference = FirebaseFirestore.instance
                          .collection('Requests')
                          .doc(widget.novelId)
                          .collection('Chapters')
                          .doc(snapshot.data.toString());
                      Map<String, dynamic> dataToSend = {
                        'chapterNum': snapshot.data,
                        'body': chapterBody,
                      };
                      getLastId();
                      try {
                        reference.set(dataToSend);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Chapter Added.')));

                        FirebaseFirestore.instance
                            .collection('Requests')
                            .doc(widget.novelId)
                            .update({'chapterNum': snapshot.data});
                      } catch (e) {}
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor, elevation: 0),
                    child: Text(
                      "Submit".toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
          ],
        ),
      ],
    );
  }

  Future<int> getLastId() async {
    int all = 1;
    try {
      var ref = await FirebaseFirestore.instance
          .collection('Requests')
          .doc(widget.novelId)
          .collection('Chapters')
          .get();

      all = int.parse(ref.docs.last.id);
    } catch (e) {
      return all = 1;
    }
    //print(++all);
    return ++all;
  }
}
