import 'package:cloud_firestore/cloud_firestore.dart';

class novelModel {
  String? Description;
  String? User;
  String? Image;
  String? Genre;
  String? Name;
  String? Id;
  int? ChapterNum;
  novelModel({
    required this.Description,
    required this.User,
    required this.Image,
    required this.Genre,
    required this.Name,
  });

  // novelModel.fromDocumentSnapshot({required DocumentSnapshot doc}) {
  //   Description = doc.data["name"];
  //   User = doc.data["author"];
  //   Image = doc.data["length"];
  //   Genre = doc.data();
  // }
  Map<String, dynamic> toJson() => {
        'rqdescription': Description,
        'rquser': User,
        'rqimg': Image,
        'rqgenre': Genre,
        'rqname': Name,
        'rqid': Id,
        'chapterNum': ChapterNum
      };
  novelModel.fromSnapshot(snapshot)
      : Description = snapshot.data()['rqdescription'],
        User = snapshot.data()['rquser'],
        Image = snapshot.data()['rqimg'],
        Genre = snapshot.data()['rqgenre'],
        Name = snapshot.data()['rqname'],
        ChapterNum = snapshot.data()['chapterNum'],
        Id = snapshot.data()['rqid'];
}
