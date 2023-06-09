import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:novel_flutter/models/novel_model.dart';

import '../../../constants.dart';
import '../../Details/details_page.dart';
//import '../../../routes/routes.dart';

class NovelCard extends StatelessWidget {
  final NovelModel novel;
  NovelCard(this.novel, {super.key});

  final String novelId = '';
  final DocumentReference documentReference =
      FirebaseFirestore.instance.collection("Requests").doc();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 380,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ]),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.center,
              child: Image.network(
                "${novel.image}",
                height: 120,
                width: 120,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: const StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                        text: '${novel.name}'),
                  ),
                ),

                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: const StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: kPrimaryColor,
                        ),
                        text: '${novel.description}'),
                  ),
                ),

                // RatingBar.builder(
                //   ignoreGestures: true,
                //   initialRating: 4,
                //   minRating: 1,
                //   direction: Axis.horizontal,
                //   itemSize: 18,
                //   itemCount: 5,
                //   itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                //   itemBuilder: (context, _) => const Icon(
                //     Icons.star,
                //     color: Colors.red,
                //   ),
                //   onRatingUpdate: (index) {},
                // ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(novel),
                      ),
                    );
                    novel.viewCount = novel.viewCount! + 1;
                    int currentView = novel.viewCount!;
                    FirebaseFirestore.instance
                        .collection('Requests')
                        .doc(novel.id)
                        .update({'viewcount': currentView});
                  },
                  child: const Text(
                    'READ NOW',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // children: const [
          //   Icon(
          //     Icons.favorite_border,
          //     color: Colors.red,
          //     size: 26,
          //   )
          // ],
          // children: [
          //   InkWell(
          //     onTap: () {
          //       Navigator.of(context).pushNamed(Routes.BOOKMARKED);
          //     },
          //     child: const Icon(
          //       Icons.favorite_border,
          //       color: Colors.red,
          //       size: 26,
          //     ),
          //   )
          // ],
          //),
          //)
        ]),
      ),
    );
  }
}
