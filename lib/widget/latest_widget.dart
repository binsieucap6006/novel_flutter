import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LatestNovelWidget extends StatelessWidget {
  const LatestNovelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(children: [
          //Single Item
          for (int i = 0; i <= 6; i++)
            Padding(
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
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/Capture1.PNG",
                        height: 120,
                        width: 150,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Nice Novel Name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "This Novel has really cool story description",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemSize: 18,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                          onRatingUpdate: (index) {},
                        ),
                        const Text(
                          "READ NOW",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 26,
                        )
                      ],
                    ),
                  )
                ]),
              ),
            )
          //End of Single Item
        ]),
      ),
    );
  }
}
