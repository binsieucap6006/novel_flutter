// ignore_for_file: file_names

class ChapterModel {
  String? body;
  int? chapterNumber;

  ChapterModel({
    required this.body,
    required this.chapterNumber,
  });

  Map<String, dynamic> toJson() => {
        'body': body,
        'chapterNum': chapterNumber,
      };
  ChapterModel.fromSnapshot(snapshot)
      : body = snapshot.data()['body'],
        chapterNumber = snapshot.data()['chapterNum'];
}
