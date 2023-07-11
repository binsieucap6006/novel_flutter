import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/routes/routes.dart';
import '../../components/background.dart';
import '../../models/novel_model.dart';

import 'components/uploaded_card.dart';
//import '../details_page.dart';

class UploadNovelScreen extends StatefulWidget {
  const UploadNovelScreen({Key? key}) : super(key: key);

  @override
  State<UploadNovelScreen> createState() => _UploadNovelScreenState();
}

class _UploadNovelScreenState extends State<UploadNovelScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  late final NovelModel novel;
  List<Object> novelList = [];
  String uID = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUID();
    uID = getUID();
    getNovelList(uID);
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<void> handleRefresh() async {
    try {
      return await Future.delayed(
        const Duration(seconds: 1),
      );
    } on Exception catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: LiquidPullToRefresh(
        color: kPrimaryColor,
        onRefresh: () {
          setState(() {
            getNovelList(uID);
          });
          return handleRefresh();
        },
        child: Column(
          children: [
            // const NavBar(
            //   title: 'Uploaded page',
            // ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(1),
              child: Column(
                children: [
                  Text(
                    'Your uploaded novels',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                  SizedBox(height: defaultPadding * 2),
                  SizedBox(height: defaultPadding * 2),
                ],
              ),
            ),
            // Row(
            //   children: <Widget>[
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: SizedBox(
            //         width: MediaQuery.of(context).size.width * 0.5,
            //         child: const Text(
            //           "Name",
            //           style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //               color: kPrimaryColor),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: SizedBox(
            //         width: MediaQuery.of(context).size.width * 0.25,
            //         child: const Text(
            //           "Chapter(s)",
            //           style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //               color: kPrimaryColor),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: SizedBox(
            //         width: MediaQuery.of(context).size.width * 0.25,
            //         child: const Text(
            //           "Action",
            //           style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //               color: kPrimaryColor),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.ADD_NOVEL);
                      },
                      icon: const Icon(
                        CupertinoIcons.plus,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: novelList.length,
                itemBuilder: (context, index) {
                  return UploadedCard(novelList[index] as NovelModel);
                },
              ),
            ),
            // for (int i = 0; i < 10; i++)
            //   Row(
            //     children: <Widget>[
            //       const SizedBox(
            //         width: 20,
            //         height: 30,
            //       ),
            //       Expanded(
            //         flex: 1,
            //         child: SizedBox(
            //           width: MediaQuery.of(context).size.width * 0.5,
            //           child: TextButton(
            //             style: TextButton.styleFrom(
            //               textStyle: const TextStyle(fontSize: 16),
            //               padding: EdgeInsets.zero,
            //               minimumSize: const Size(50, 30),
            //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //               alignment: Alignment.centerLeft,
            //             ),
            //             onPressed: () {
            //               // Navigator.of(context).push(
            //               //   MaterialPageRoute(
            //               //     builder: (context) => DetailsPage(
            //               //         "Novel's Name",
            //               //         "Novel's Name",
            //               //         "Novel's Name",
            //               //         "Novel's Name",
            //               //         "Novel's Name"),
            //               //   ),
            //               // );
            //             },
            //             child: const Text(
            //               "Novel's Name",
            //               style: TextStyle(color: Colors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 1,
            //         child: SizedBox(
            //           width: MediaQuery.of(context).size.width * 0.25,
            //           child: const Text(
            //             "92",
            //             style: TextStyle(
            //               fontSize: 16,
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 1,
            //         child: SizedBox(
            //           width: MediaQuery.of(context).size.width * 0.25,
            //           child: TextButton(
            //             style: TextButton.styleFrom(
            //               textStyle: const TextStyle(fontSize: 16),
            //               padding: EdgeInsets.zero,
            //               minimumSize: const Size(50, 30),
            //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //               alignment: Alignment.centerLeft,
            //             ),
            //             onPressed: () {
            //               Navigator.of(context).pushNamed(Routes.ADD_CHAPTER);
            //             },
            //             child: const Text(
            //               'Add chapter',
            //               style: TextStyle(color: Colors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }

  Future getNovelList(String uID) async {
    //final uid = AuthService()
    var data = await FirebaseFirestore.instance
        .collection('Requests')
        .where("rquser", isEqualTo: uID)
        .get();
    setState(() {
      novelList =
          List.from(data.docs.map((doc) => NovelModel.fromSnapshot(doc)));
    });
  }

  String getUID() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid!;
    // here you write the codes to input the data into firestore
  }
}
