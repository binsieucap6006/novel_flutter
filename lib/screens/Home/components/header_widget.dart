//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/Home/components/header_search.dart';

import '../../../constants.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.search,
                color: kPrimaryColor,
                size: 30,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: "What would you like to read?",
                      border: InputBorder.none,
                      fillColor: kPrimaryLightColor,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => const HeaderSearchScreen()));
                    },
                  ),
                ),
              ),
              const Icon(Icons.filter_list, color: kPrimaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
