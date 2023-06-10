// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:novel_flutter/models/chapterModel.dart';
import 'package:novel_flutter/models/novelModel.dart';

class UserModel {
  String img =
      "https://firebasestorage.googleapis.com/v0/b/novelhovel-8a04e.appspot.com/o/avt%2F324337349_920142589000241_7555360052804976216_n.jpg?alt=media&token=dd34a3ff-ddda-404c-a32d-457fe2827547&_gl=1*z3c246*_ga*MTAwMzkzMTQwLjE2ODUwNjk1Njc.*_ga_CW55HF8NVT*MTY4NjMwODUwOC4xMy4xLjE2ODYzMTA1MDcuMC4wLjA.";
  //String? uid;
  String? email;
  String? fullName;
  bool admin = false;
  String? uid;
  UserModel({
    required this.email,
    required this.fullName,
    //required this.uid,
  });

  // UserModel.fromDocumentSnapshot({required DocumentSnapshot doc}) {
  //   uid = doc.documentID;
  // }
  Map<String, dynamic> toJson() => {
        'img': img,
        'email': email,
        'fullname': fullName,
        'admin': admin,
        'uid': uid
      };
  UserModel.fromSnapshot(snapshot)
      : img = snapshot.data()['img'],
        email = snapshot.data()['email'],
        fullName = snapshot.data()['fullname'],
        uid = snapshot.data()['uid'],
        admin = snapshot.data()['admin'];
}
