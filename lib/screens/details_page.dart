import 'package:flutter/material.dart';
import 'package:novel_flutter/models/novelModel.dart';
import 'package:novel_flutter/screens/Chapter/chapter_screen.dart';

import '../components/background.dart';
import '../constants.dart';
import '../routes/routes.dart';

class DetailsPage extends StatelessWidget {
  // String name;
  // String genre;
  // String user;
  // String img;
  // String description;
  DetailsPage(this.novel, {super.key});

  novelModel novel;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                //SizedBox(height: 10),
                Center(
                  child: Image.network(
                    novel.Image!,
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        novel.Name!,
                        style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            "Categories: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            novel.Genre!,
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Description: ",
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Text(
                        novel.Description!,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 40),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          //Navigator.of(context).pushNamed(Routes.BOOKMARKED);
                          print(novel.Id);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Icon(
                            Icons.favorite_border,
                            size: 40,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 240),
                        child: Icon(
                          Icons.thumb_up,
                          size: 40,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
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
                              color: kPrimaryColor,
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
