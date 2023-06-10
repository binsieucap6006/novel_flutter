import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';
import '../../components/background.dart';

import '../Home/components/navbar_widget.dart';
import '../details_page.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: ListView(
        children: [
          const NavBar(),
          const SizedBox(
            height: 50,
          ),
          //UploadNovelList(),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              children: const [
                Text(
                  'Bookmarked',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                SizedBox(height: defaultPadding * 2),
                SizedBox(height: defaultPadding * 2),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: const Text(
                    "Chapter(s)",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: const Text(
                    "Action",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          for (int i = 0; i < 10; i++)
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 20,
                  height: 30,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => DetailsPage(
                        //       "Novel's Name",
                        //       "Novel's Name",
                        //       "Novel's Name",
                        //       "Novel's Name",
                        //       "Novel's Name",
                        //     ),
                        //   ),
                        // );
                      },
                      child: const Text(
                        "Novel's Name",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: const Text(
                      "92",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => DetailsPage(
                        //       "Novel's Name",
                        //       "Novel's Name",
                        //       "Novel's Name",
                        //       "Novel's Name",
                        //       "Novel's Name",
                        //     ),
                        //   ),
                        // );
                      },
                      child: const Text(
                        'Read now',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
