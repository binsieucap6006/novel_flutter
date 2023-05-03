import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_flutter/constants.dart';
import '../../../components/background.dart';
import '../../../widget/navbar_widget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Background(
      child: Column(
        children: [
          const NavBar(),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Admin page',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: const <Widget>[
                  CategoryCard(title: 'User Management', imgSrc: 'assets/icons/user.png',),
                  CategoryCard(title: 'Novel Management', imgSrc: 'assets/icons/user.png',),
                  CategoryCard(title: 'Data Management', imgSrc: 'assets/icons/user.png',),
                  CategoryCard(title: 'Other Management', imgSrc: 'assets/icons/user.png',),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imgSrc;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imgSrc,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryLightColor,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(13),
        splashColor: kPrimaryPurpleSplashColor,
        highlightColor: kPrimaryPurpleColor,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            const Spacer(),
            Container(
                constraints: const BoxConstraints(
                  maxHeight: 70,
                  minWidth: 70,
                ),
                child: Image.asset(imgSrc)),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
          ]),
        ),
      ),
    );
  }
}
