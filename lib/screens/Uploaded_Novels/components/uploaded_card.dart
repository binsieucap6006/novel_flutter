import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/Add_Chapter/add_chappter_screen.dart';

import '../../../constants.dart';
import '../../../models/novel_model.dart';
import '../../Details/details_page.dart';

// ignore: must_be_immutable
class UploadedCard extends StatefulWidget {
  UploadedCard(this.novel, {super.key});
  NovelModel novel;

  @override
  State<UploadedCard> createState() => _UploadedCardState();
}

class _UploadedCardState extends State<UploadedCard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.novel.chapterNum;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        child: Card(
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 10, top: 10, bottom: 10),
                    child: Image.network(
                      '${widget.novel.image}',
                      height: 80,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.novel.name}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Chapter: ${widget.novel.chapterNum}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 10, top: 10, bottom: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddChapterScreen(
                          novelId: widget.novel.id!,
                          novelName: widget.novel.name!,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Add Chapter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
            // title: Text(
            //   '${novel.Name}',
            //   style: const TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //     color: kPrimaryColor,
            //   ),
            // ),
            // contentPadding: const EdgeInsets.all(10),
            // leading: Image.network(
            //   '${novel.Image}',
            //   height: 100,
            //   width: 100,
            //   fit: BoxFit.fitWidth,
            // ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailsPage(widget.novel),
            ),
          );
        },
      ),
    );
  }
}
