import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/testing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/components/background.dart';
import 'package:novel_flutter/screens/Home/components/navbar_widget.dart';
import 'package:novel_flutter/screens/Home/components/search_card.dart';

import '../../../constants.dart';
import '../../../models/novelModel.dart';
import '../../details_page.dart';

class HeaderSearchScreen extends StatefulWidget {
  const HeaderSearchScreen({super.key});

  @override
  State<HeaderSearchScreen> createState() => _HeaderSearchScreenState();
}

class _HeaderSearchScreenState extends State<HeaderSearchScreen> {
  String inputTxt = '';
  late final novelModel novel;
  List<Object> novelList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getNovelList();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          NavBar(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.search,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "What would you like to read?",
                            border: InputBorder.none,
                            fillColor: kPrimaryLightColor,
                          ),
                          onChanged: (value) {
                            setState(() {
                              inputTxt = value;
                              print(inputTxt);
                              getNovelList();
                            });
                          },
                        ),
                      ),
                    ),
                    const Icon(Icons.filter_list, color: kPrimaryColor),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: novelList.length,
              itemBuilder: (context, index) {
                return SearchCard(novelList[index] as novelModel);
              },
            )),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Background(
  //     child: Column(
  //       children: [
  //         NavBar(),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(
  //             vertical: 10,
  //             horizontal: 15,
  //           ),
  //           child: Container(
  //             width: double.infinity,
  //             height: 50,
  //             decoration: BoxDecoration(
  //                 color: kPrimaryLightColor,
  //                 borderRadius: BorderRadius.circular(20),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.grey.withOpacity(0.5),
  //                     spreadRadius: 2,
  //                     blurRadius: 10,
  //                     offset: const Offset(0, 3),
  //                   )
  //                 ]),
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 10,
  //               ),
  //               child: Row(
  //                 children: [
  //                   const Icon(
  //                     CupertinoIcons.search,
  //                     color: kPrimaryColor,
  //                     size: 30,
  //                   ),
  //                   SizedBox(
  //                     height: 50,
  //                     width: 300,
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                         horizontal: 15,
  //                       ),
  //                       child: TextFormField(
  //                         decoration: const InputDecoration(
  //                           hintText: "What would you like to read?",
  //                           border: InputBorder.none,
  //                           fillColor: kPrimaryLightColor,
  //                         ),
  //                         onChanged: (value) {
  //                           setState(() {
  //                             inputTxt = value;
  //                             print(inputTxt);
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                   const Icon(Icons.filter_list, color: kPrimaryColor),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: Container(
  //             child: StreamBuilder(
  //               stream: FirebaseFirestore.instance
  //                   .collection("Requests")
  //                   .where("rqname", isGreaterThanOrEqualTo: inputTxt)
  //                   .snapshots(),
  //               builder: (BuildContext context,
  //                   AsyncSnapshot<QuerySnapshot> snapshot) {
  //                 if (snapshot.hasError) {
  //                   return Center(
  //                     child: Text(
  //                       "Something went wrong, please try again.",
  //                       style: TextStyle(
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.grey),
  //                     ),
  //                   );
  //                 } else if (snapshot.connectionState ==
  //                     ConnectionState.waiting) {
  //                   return Center(
  //                     child: Text(
  //                       "Loading... please be patient.",
  //                       style: TextStyle(
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.grey),
  //                     ),
  //                   );
  //                 }
  //                 return ListView(
  //                   children:
  //                       snapshot.data!.docs.map((DocumentSnapshot document) {
  //                     novelList = List.from(snapshot.data!.docs
  //                         .map((doc) => novelModel.fromSnapshot(doc)));
  //                     Map<String, dynamic> data =
  //                         document.data() as Map<String, dynamic>;
  //                     return Padding(
  //                       padding: const EdgeInsets.all(5),
  //                       child: InkWell(
  //                         child: Card(
  //                           elevation: 10,
  //                           child: ListTile(
  //                             title: Text(
  //                               data['rqname'],
  //                               style: TextStyle(
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: kPrimaryColor,
  //                               ),
  //                             ),
  //                             contentPadding: EdgeInsets.all(10),
  //                             leading: Image.network(
  //                               data['rqimg'],
  //                               height: 100,
  //                               width: 100,
  //                               fit: BoxFit.fitWidth,
  //                             ),
  //                           ),
  //                         ),
  //                         onTap: () {
  //                           Navigator.of(context).push(
  //                             MaterialPageRoute(
  //                               builder: (context) =>
  //                                   DetailsPage(novelList[1] as novelModel),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     );
  //                   }).toList(),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Future getNovelList() async {
    //final uid = AuthService()
    var data = await FirebaseFirestore.instance
        .collection('Requests')
        .where("rqname", isGreaterThanOrEqualTo: inputTxt)
        .get();
    setState(() {
      novelList =
          List.from(data.docs.map((doc) => novelModel.fromSnapshot(doc)));
    });
  }
}
