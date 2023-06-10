import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/models/userModel.dart';
import 'package:novel_flutter/screens/Admin/components/user_card.dart';
import '../../../components/background.dart';
import '../Home/components/navbar_widget.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<Object> userList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: <Widget>[
          NavBar(),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              //itemCount: userList.length,
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                return UserCard(userList[index] as UserModel);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future getUserList() async {
    //final uid = AuthService()
    var data = await FirebaseFirestore.instance
        .collection('Users')
        //.orderBy("fullname", descending: true)
        .where("admin", isEqualTo: false)
        .get();
    setState(() {
      userList = List.from(data.docs.map((doc) => UserModel.fromSnapshot(doc)));
    });
  }

  bool parseBool(String input) {
    if (input.toLowerCase() == 'true') {
      return true;
    } else if (input.toLowerCase() == 'false') {
      return false;
    }

    throw '"$input" can not be parsed to boolean.';
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
