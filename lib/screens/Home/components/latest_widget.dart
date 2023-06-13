import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:novel_flutter/screens/Home/components/novel_card.dart';
//import 'package:novel_flutter/screens/details_page.dart';
import 'package:novel_flutter/models/novel_model.dart';

//import '../../../constants.dart';
//import '../../../routes/routes.dart';

class LatestNovelWidget extends StatefulWidget {
  const LatestNovelWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return LatestNovelWidgetState();
  }
}

class LatestNovelWidgetState extends State<LatestNovelWidget> {
  List<Object> novelList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getNovelList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(children: [
            //Single Item
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: novelList.length,
              itemBuilder: (context, index) {
                return NovelCard(novelList[index] as NovelModel);
              },
            )
            //     for (int i = 0; i <= 6; i++)

            //End of Single Item
          ]),
        ),
      ],
      //child:
    );
  }

  Future getNovelList() async {
    //final uid = AuthService()
    var data = await FirebaseFirestore.instance
        .collection('Requests')
        //.where('rquser', isEqualTo: )
        .orderBy("time", descending: true)
        .get();
    setState(() {
      novelList =
          List.from(data.docs.map((doc) => NovelModel.fromSnapshot(doc)));
    });
  }
}
