import 'package:flutter/material.dart';

import '../components/background.dart';
import 'Chapter/chapter_screen.dart';

class DetailsPage extends StatelessWidget {
  String img;
  DetailsPage(this.img, {super.key});
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
                //SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    "assets/images/Capture1.PNG",
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),
                ),

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        img,
                        style: const TextStyle(
                            fontSize: 30,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: const [
                          Text(
                            "Categories: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Action, Sci-fi",
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Description: ",
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Description is the pattern of narrative development that aims to make vivid a place, object, character, or group. Description is one of four rhetorical modes, along with exposition, argumentation, and narration. In practice it would be difficult to write literature that drew on just one of the four basic modes",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 40),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Icon(
                          Icons.bookmark,
                          size: 40,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 240),
                        child: Icon(
                          Icons.thumb_up,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 25, right: 40),
                  child: Text(
                    "Chapters",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 30),
                for (int i = 0; i < 10; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Chapter ${i + 1}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 210),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChapterScreen(i + 1),
                              ),
                            );
                          },
                          child: const Text(
                            'READ NOW',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                // Row(
                //   children: [
                //     Text(
                //       "Chapter ${i}",
                //       style: TextStyle(fontSize: 14),
                //     ),
                //     SizedBox(width: 300),
                //     Text(
                //       "READ NOW",
                //       style: TextStyle(fontSize: 14),
                //     ),
                //     SizedBox(height: 40),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
