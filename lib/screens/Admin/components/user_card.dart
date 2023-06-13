import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/models/userModel.dart';

class UserCard extends StatefulWidget {
  final UserModel user;
  const UserCard(this.user, {super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  // Future<void> deleteUser(id) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
//DocumentReference documentReference = FirebaseFirestore.instance.collection('Users')
  Future<void> deleteUser(String? uid) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(uid);
    return documentReference
        //.doc(uid!)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Card(
        color: Colors.cyan[100],
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 55.0,
                    height: 55.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.green,
                      backgroundImage: NetworkImage(widget.user.img),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${widget.user.fullName}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${widget.user.email}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      // Text(
                      //   "subTitle[index]",
                      //   style: TextStyle(color: Colors.grey),
                      // ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shadowColor: Colors.redAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      onPressed: () async {
                        deleteUser(widget.user.uid);

                        //print(widget.user.uid);
                        setState(() {});
                      },
                      child: const Text(
                        'Lock',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void delUser() async {
  //   User? user = await _auth.currentUser;
  //   AuthCredential credential =
  //       EmailAuthProvider.credential(email: "", password: "password");
  //   user?.delete();
  // }
}
