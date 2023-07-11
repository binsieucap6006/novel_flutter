import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/novel_model.dart';
import '../../../routes/routes.dart';
import '../../Details/details_page.dart';

class TrendingItemWidget extends StatelessWidget {
  //const TrendingItemWidget({super.key});
  final NovelModel novel;
  TrendingItemWidget(this.novel, {super.key});
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              // children: const [
              //   Icon(
              //     Icons.favorite_border,
              //     color: Colors.red,
              //     size: 26,
              //   )
              // ],
              children: [
                Text(
                  novel.viewCount.toString() + ' Views',
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kPrimaryColor.withOpacity(0.6),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    //   margin: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(20),
    //     color: Colors.white,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.withOpacity(0.5),
    //         spreadRadius: 1,
    //         blurRadius: 8,
    //       )
    //     ],
    //   ),
    //   child: Column(
    //     children: [
    //       Container(
    //         margin: const EdgeInsets.all(5),
    //         child: Image.asset(
    //           //"images/${img[i]}.png",
    //           "assets/images/Capture1.PNG",
    //           width: 150,
    //           height: 120,
    //           fit: BoxFit.fitWidth,
    //         ),
    //       ),
    //       const Padding(
    //         padding: EdgeInsets.only(top: 10),
    //         child: Align(
    //           alignment: Alignment.centerLeft,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 "Best Novel Ever",
    //                 style: TextStyle(
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               SizedBox(height: 5),
    //               Text(
    //                 "Nice description, Nice description, Nice description, Nice description, Nice description, Nice description,",
    //                 style: TextStyle(
    //                   fontSize: 10,
    //                   color: kPrimaryColor,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(bottom: 1),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             const Text(
    //               "9999 Views",
    //               style: TextStyle(
    //                 fontSize: 12,
    //               ),
    //             ),
    //             TextButton(
    //               style: TextButton.styleFrom(
    //                 textStyle: const TextStyle(fontSize: 16),
    //               ),
    //               onPressed: () {
    //                 // Navigator.of(context).push(
    //                 //   MaterialPageRoute(
    //                 //     builder: (context) => DetailsPage(
    //                 //         "Best Novel Ever",
    //                 //         "Best Novel Ever",
    //                 //         "Best Novel Ever",
    //                 //         "Best Novel Ever",
    //                 //         "Best Novel Ever"),
    //                 //   ),
    //                 // );
    //               },
    //               child: const Text(
    //                 'READ NOW',
    //                 style: TextStyle(
    //                   color: kPrimaryColor,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    // return GridView.count(
    //   physics: const NeverScrollableScrollPhysics(),
    //   crossAxisCount: 2,
    //   shrinkWrap: true,
    //   childAspectRatio: (150 / 190),
    //   children: [
    //     for (int i = 0; i < 10; i++)
    //       Container(
    //         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    //         margin: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(20),
    //           color: Colors.white,
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.grey.withOpacity(0.5),
    //               spreadRadius: 1,
    //               blurRadius: 8,
    //             )
    //           ],
    //         ),
    //         child: Column(
    //           children: [
    //             InkWell(
    //               onTap: () {},
    //               child: Container(
    //                 margin: const EdgeInsets.all(5),
    //                 child: Image.asset(
    //                   //"images/${img[i]}.png",
    //                   "assets/images/Capture1.PNG",
    //                   width: 150,
    //                   height: 120,
    //                   fit: BoxFit.fitWidth,
    //                 ),
    //               ),
    //             ),
    //             const Padding(
    //               padding: EdgeInsets.only(top: 10),
    //               child: Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "Best Novel Ever",
    //                       style: TextStyle(
    //                         fontSize: 18,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     SizedBox(height: 5),
    //                     Text(
    //                       "Nice description, Nice description, Nice description, Nice description, Nice description, Nice description,",
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: kPrimaryColor,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(bottom: 1),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   const Text(
    //                     "9999 Views",
    //                     style: TextStyle(
    //                       fontSize: 12,
    //                     ),
    //                   ),
    //                   TextButton(
    //                     style: TextButton.styleFrom(
    //                       textStyle: const TextStyle(fontSize: 16),
    //                     ),
    //                     onPressed: () {
    //                       // Navigator.of(context).push(
    //                       //   MaterialPageRoute(
    //                       //     builder: (context) => DetailsPage(
    //                       //         "Best Novel Ever",
    //                       //         "Best Novel Ever",
    //                       //         "Best Novel Ever",
    //                       //         "Best Novel Ever",
    //                       //         "Best Novel Ever"),
    //                       //   ),
    //                       // );
    //                     },
    //                     child: const Text(
    //                       'READ NOW',
    //                       style: TextStyle(
    //                         color: kPrimaryColor,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //   ],
    // );
  }
}
