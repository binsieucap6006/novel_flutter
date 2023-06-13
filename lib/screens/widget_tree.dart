import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:novel_flutter/screens/Add_Novel/add_novel_screen.dart';

import 'package:novel_flutter/states/current_user.dart';

import 'Admin/admin_screen.dart';
import 'Home/components/appbar_widget.dart';
import 'Welcome/welcome_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});
  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: buildBottomBar(),
      body: StreamBuilder(
        stream: CurrentUser().authStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (route() == 1) {
              return const AdminScreen();
            } else {
              return const SimpleAppBarPage();
            }
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }

  Widget buildBottomBar() {
    const style = TextStyle(color: Colors.white);

    return BottomNavigationBar(
      backgroundColor: Colors.purple,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
          icon: Text('AppBar', style: style),
          label: 'Transparent',
        ),
        BottomNavigationBarItem(
          icon: Text('AppBar', style: style),
          label: 'Transparent',
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }

  int route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('Users').doc(user!.uid).get().then(
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
