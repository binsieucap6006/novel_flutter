import 'package:flutter/material.dart';
import 'package:novel_flutter/models/novel_model.dart';

import '../../../constants.dart';

class RequestCard extends StatelessWidget {
  final NovelModel novel;
  const RequestCard(this.novel, {super.key});

  Future<String> getUsernamebyId(String? uid) async {
    String name = "";
    // var document =
    //     await FirebaseFirestore.instance.collection('Users').doc(uid).get();
//.then((value) => name = value.data()!["fullname"])
    return name;
  }

  String requestType(String num) {
    int number = int.parse(num);
    switch (number) {
      case 0:
        return "Pending";
      case 1:
        return "Accepted";
      case 2:
        return "Rejected";
      default:
        return "Pending";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: getUsernamebyId(novel.user!),
          builder: ((context, snapshot) => CategoryCard(
                //typeReqest: requestType("0"),
                //sender: "snapshot.data",
                nameNovel: novel.name!,
                typeNovel: novel.genre!,
                descriptionNovel: novel.description!,
                imgNovel: novel.image!,
              )),
          // child: CategoryCard(
          //   typeReqest: requestType("0"),
          //   sender: .then((value) => {print(value)}),
          //   nameNovel: novel.Name!,
          //   typeNovel: novel.Genre!,
          //   descriptionNovel: novel.Description!,
          //   imgNovel: novel.Image!,
          // ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  //final String typeReqest;
  //final String? sender;
  final String nameNovel;
  final String typeNovel;
  final String descriptionNovel;
  final String imgNovel;

  const CategoryCard({
    super.key,
    //required this.typeReqest,
    //required this.sender,
    required this.nameNovel,
    required this.typeNovel,
    required this.descriptionNovel,
    required this.imgNovel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryLightColor,
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   'Request: $typeReqest',
                    //   style: const TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //       color: kPrimaryColor),
                    // ),
                    // Flexible(
                    //   child: RichText(
                    //     overflow: TextOverflow.ellipsis,
                    //     strutStyle: const StrutStyle(fontSize: 12.0),
                    //     text: TextSpan(
                    //         style: const TextStyle(
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold,
                    //           color: kPrimaryColor,
                    //         ),
                    //         text: 'Sender: $sender'),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 160,
                    width: 240,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: const StrutStyle(fontSize: 12.0),
                            text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'Name: $nameNovel'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Type: $typeNovel',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: const StrutStyle(fontSize: 12.0),
                            text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                text: 'Description: $descriptionNovel'),
                          ),
                        ),
                        const Text(
                          '',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      constraints: const BoxConstraints(
                        maxHeight: 120,
                        minWidth: 120,
                      ),
                      child: Image.network(
                        imgNovel,
                        height: 120,
                        width: 120,
                        fit: BoxFit.fill,
                      )),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 30,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onPressed: () {},
                      child: const Text('Edit'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shadowColor: Colors.redAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onPressed: () {},
                      child: const Text('Decline'),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
