import 'package:flutter/material.dart';
import '../../../constants.dart';

class TrendingItemWidget extends StatelessWidget {
  const TrendingItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: (150 / 190),
      children: [
        for (int i = 0; i < 10; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 8,
                )
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      //"images/${img[i]}.png",
                      "assets/images/Capture1.PNG",
                      width: 150,
                      height: 120,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Best Novel Ever",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Nice description, Nice description, Nice description, Nice description, Nice description, Nice description,",
                          style: TextStyle(
                            fontSize: 10,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "9999 Views",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => DetailsPage(
                          //         "Best Novel Ever",
                          //         "Best Novel Ever",
                          //         "Best Novel Ever",
                          //         "Best Novel Ever",
                          //         "Best Novel Ever"),
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
              ],
            ),
          )
      ],
    );
  }
}
