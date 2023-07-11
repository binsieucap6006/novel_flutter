import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../constants.dart';
import '../../models/novel_model.dart';
import 'components/trending_item_widget.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  List<Object> novelList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getNovelList();
  }

  Future getNovelList() async {
    //final uid = AuthService()
    var data = await FirebaseFirestore.instance
        .collection('Requests')
        //.where('rquser', isEqualTo: )
        .orderBy("viewcount", descending: true)
        .get();
    setState(() {
      novelList =
          List.from(data.docs.map((doc) => NovelModel.fromSnapshot(doc)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            //HeaderWidget(),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Most views of all time",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
            //TrendingItemWidget(),
            Expanded(
              child: ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                //childAspectRatio: (150 / 190),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: novelList.length,
                itemBuilder: (context, index) {
                  if (novelList.isNotEmpty) {
                    return TrendingItemWidget(novelList[index] as NovelModel);
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
