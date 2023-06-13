class NovelModel {
  String? description;
  String? user;
  String? image;
  String? genre;
  String? name;
  String? id;
  int? chapterNum;
  int? viewCount;
  NovelModel({
    required this.description,
    required this.user,
    required this.image,
    required this.genre,
    required this.name,
  });

  // novelModel.fromDocumentSnapshot({required DocumentSnapshot doc}) {
  //   Description = doc.data["name"];
  //   User = doc.data["author"];
  //   Image = doc.data["length"];
  //   Genre = doc.data();
  // }
  Map<String, dynamic> toJson() => {
        'rqdescription': description,
        'rquser': user,
        'rqimg': image,
        'rqgenre': genre,
        'rqname': name,
        'rqid': id,
        'chapterNum': chapterNum,
        'viewcount': viewCount,
      };
  NovelModel.fromSnapshot(snapshot)
      : description = snapshot.data()['rqdescription'],
        user = snapshot.data()['rquser'],
        image = snapshot.data()['rqimg'],
        genre = snapshot.data()['rqgenre'],
        name = snapshot.data()['rqname'],
        chapterNum = snapshot.data()['chapterNum'],
        viewCount = snapshot.data()['viewcount'],
        id = snapshot.data()['rqid'];
}
