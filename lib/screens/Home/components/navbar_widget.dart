import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/routes/routes.dart';
import 'package:novel_flutter/states/current_user.dart';

import '../../../models/userModel.dart';

enum SampleItem {
  logout,
  setting,
  uploadNovel,
  bookmarked,
  uploaded,
}

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const NavBar({super.key, required this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Sign out"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        Navigator.of(context).pushNamed(Routes.LOGIN);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: const Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final UserModel user = UserModel(email: '', fullName: '');
  String uID = '';
  String img = '';
  String name = '';
  Object userList = Object();
  DocumentSnapshot? documentSnapshot;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUID();
    uID = getUID();
    getUser();
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("Users").doc(uID).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/novel-hovel-word.png',
                    width: 150,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      //padding: const EdgeInsets.all(8),
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
                        ],
                      ),
                      //child: const Icon(CupertinoIcons.bars),
                      // child: IconButton(
                      //   icon: const Icon(CupertinoIcons.bars),
                      //   onPressed: () {
                      // CurrentUser().signOutUser();
                      // Navigator.of(context).pushNamed(Routes.WELCOME);
                      //   },
                      // ),
                      child: PopupMenuButton<SampleItem>(
                        child: Row(
                          children: [
                            InkWell(
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.green,
                                backgroundImage:
                                    NetworkImage(snapshot.data!['img']),
                              ),
                            )
                          ],
                        ),
                        onSelected: (Enum selectedItem) {
                          if (selectedItem == SampleItem.logout) {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'Are you sure',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                content: const Text('You want to log out?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      CurrentUser().signOutUser();
                                      Navigator.of(context)
                                          .pushNamed(Routes.WELCOME);
                                    },
                                    child: Text(
                                      'Log out',
                                      style: TextStyle(
                                          color: Colors.red.withOpacity(0.8)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (selectedItem == SampleItem.setting) {
                            Navigator.of(context).pushNamed('/');
                          } else if (selectedItem == SampleItem.uploadNovel) {
                            Navigator.of(context).pushNamed(Routes.ADD_NOVEL);
                          } else if (selectedItem == SampleItem.bookmarked) {
                            Navigator.of(context).pushNamed(Routes.BOOKMARKED);
                          } else if (selectedItem == SampleItem.uploaded) {
                            Navigator.of(context).pushNamed(Routes.UPLOADED);
                          }
                        },
                        //icon: const Icon(CupertinoIcons.bars),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<SampleItem>>[
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.logout,
                            child: Text('Log out'),
                          ),
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.setting,
                            child: Text('Setting'),
                          ),
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.uploadNovel,
                            child: Text('Upload Novel'),
                          ),
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.bookmarked,
                            child: Text('Bookmark'),
                          ),
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.uploaded,
                            child: Text('Uploaded novels'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // FutureBuilder(
                  //   future: FirebaseFirestore.instance
                  //       .collection("Users")
                  //       .doc(UID)
                  //       .get(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return Text(snapshot.data!['fullname'].toString());
                  //     } else {
                  //       return Center(child: Text(""));
                  //     }
                  //   },
                  // ),
                  Text(documentSnapshot!['fullname']),
                  //Text(FirebaseAuth.instance.currentUser!.uid),
                ],
              );
            } else {
              return const Text('null');
            }
          }),
    );
  }

  Future getUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        //.orderBy("fullname", descending: true)
        //.where("admin", isEqualTo: false)
        //.where("uid", isEqualTo: UID)
        .get();
    setState(() {
      //userList = data.docs.map((doc) => UserModel.fromSnapshot(doc));
    });
  }

  // Future getUserInfo(String UID) async {
  //   var user = UserModel(email: '', fullName: '').obs;
  //   //final uid = AuthService()
  //   var data = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(UID)
  //       //.orderBy("fullname", descending: true)
  //       //.where("admin", isEqualTo: false)
  //       .snapshots()
  //       .listen((event) {user.e});
  // }

  String getUID() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid!;
    // here you write the codes to input the data into firestore
  }
}
