import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/Add_Novel/add_novel_screen.dart';

import 'package:novel_flutter/states/current_user.dart';

import 'Admin/admin_screen.dart';
import 'Home/home_page.dart';
import 'Welcome/welcome_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});
  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CurrentUser().authStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (route() == 1) {
            return AdminScreen();
          } else {
            return HomePage();
          }
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }

  int route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get('admin')) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AdminScreen(),
            //   ),
            // );
            return 1;
          } else {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => HomePage(),
            //   ),
            // );
            return 2;
          }
        } else {
          //print('Document does not exist on the database');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Document does not exist on the database."),
              duration: Duration(seconds: 2),
            ),
          );
          return 0;
        }
      },
    );
    return 0;
  }
}
