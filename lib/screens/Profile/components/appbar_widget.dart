import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: BackButton(),
    backgroundColor: kPrimaryColor,
    elevation: 0,
    title: Padding(
      padding: EdgeInsets.only(
        left: 120,
      ),
      child: Text(
        'Profile',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
