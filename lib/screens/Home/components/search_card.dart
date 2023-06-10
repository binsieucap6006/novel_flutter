import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/novelModel.dart';
import '../../details_page.dart';

class SearchCard extends StatelessWidget {
  SearchCard(this.novel, {super.key});
  novelModel novel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        child: Card(
          elevation: 10,
          child: ListTile(
            title: Text(
              '${novel.Name}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            contentPadding: EdgeInsets.all(10),
            leading: Image.network(
              '${novel.Image}',
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
