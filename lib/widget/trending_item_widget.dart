import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/details_page.dart';

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
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
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
                      width: 140,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Best Novel Ever",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Nice description",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "9999 Views",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage("Best Novel Ever"),
                            ),
                          );
                        },
                        child: const Text(
                          'READ NOW',
                          style: TextStyle(
                            color: Colors.grey,
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