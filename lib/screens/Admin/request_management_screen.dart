import 'dart:ffi';
import 'package:novel_flutter/models/novelModel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/screens/Admin/components/request_card.dart';
import '../../../components/background.dart';
import '../../states/Current_User.dart';
import '../Home/components/navbar_widget.dart';

class RequestManagementScreen extends StatefulWidget {
  const RequestManagementScreen({Key? key}) : super(key: key);

  @override
  State<RequestManagementScreen> createState() =>
      _RequestManagementScreenState();
}

class _RequestManagementScreenState extends State<RequestManagementScreen> {
  final User? user = CurrentUser().currentUser;
  List<Object> novelList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getNovelList();
  }

  Future getNovelList() async {
    //final uid = AuthService()
    var data = await FirebaseFirestore.instance
        .collection('Requests')
        .orderBy("time", descending: true)
        .get();
    setState(() {
      novelList =
          List.from(data.docs.map((doc) => novelModel.fromSnapshot(doc)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          NavBar(),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              // child: GridView.builder(
              //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              //     maxCrossAxisExtent: 400,
              //     childAspectRatio: 1.5,
              //     crossAxisSpacing: 20,
              //     mainAxisSpacing: 20,
              //   ),
              //   itemCount: novelList.length,
              //   itemBuilder: (context, index) {
              //     return RequestCard(novelList[index] as novelModel);
              //   },
              // ),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: novelList.length,
                itemBuilder: (context, index) {
                  return RequestCard(novelList[index] as novelModel);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoRequestStatus extends StatelessWidget {
  const NoRequestStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            'There is no request at the moment :((',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
