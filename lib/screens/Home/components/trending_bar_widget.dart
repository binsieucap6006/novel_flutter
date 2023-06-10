import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/details_page.dart';

import '../../../constants.dart';

class TrendingNovelWidget extends StatelessWidget {
  const TrendingNovelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: [
            //Single Item
            for (int i = 0; i <= 6; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: 170,
                  height: 235,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/Capture1.PNG",
                            height: 100,
                            width: 140,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Greatest Novel Ever",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => DetailsPage(
                            //       "Greatest Novel Ever",
                            //       "Greatest Novel Ever",
                            //       "Greatest Novel Ever",
                            //       "Greatest Novel Ever",
                            //       "Greatest Novel Ever",
                            //     ),
                            //   ),
                            // );
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
                ),
              ),
            //End of Single Item
          ],
        ),
      ),
    );
  }
}
