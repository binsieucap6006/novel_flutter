import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/routes/routes.dart';
import 'package:novel_flutter/screens/Login/login_screen.dart';
import 'package:novel_flutter/screens/Signup/signup_screen.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              //child: const Icon(CupertinoIcons.bars),
              child: PopupMenuButton<SampleItem>(
                onSelected: (Enum selectedItem) {
                  if (selectedItem == SampleItem.itemOne) {
                    Navigator.of(context).pushNamed(Routes.LOGIN);
                  } else if (selectedItem == SampleItem.itemTwo) {
                    Navigator.of(context).pushNamed(Routes.SIGN_UP);
                  }
                },
                icon: const Icon(CupertinoIcons.bars),
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SampleItem>>[
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.itemOne,
                    child: const Text('Log in'),
                  ),
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.itemTwo,
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              "Novel Reader",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.UPLOADED);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: const Icon(Icons.notifications),
            ),
          ),
        ],
      ),
    );
  }
}
