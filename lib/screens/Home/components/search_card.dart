import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/novel_model.dart';
import '../../Details/details_page.dart';

// ignore: must_be_immutable
class SearchCard extends StatelessWidget {
  SearchCard(this.novel, {super.key});
  NovelModel novel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        child: Card(
          elevation: 10,
          child: ListTile(
            title: Text(
              '${novel.name}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            contentPadding: const EdgeInsets.all(10),
            leading: Image.network(
              '${novel.image}',
              height: 100,
              width: 100,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailsPage(novel),
            ),
          );
        },
      ),
    );
  }
}
