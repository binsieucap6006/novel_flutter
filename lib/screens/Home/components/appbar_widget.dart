// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:novel_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/Home/components/header_search.dart';
import 'package:novel_flutter/screens/Home/home_page.dart';
import 'package:novel_flutter/screens/Uploaded_Novels/upload_novels_screen.dart';

import '../../../models/userModel.dart';
import '../../../routes/routes.dart';
import '../../../states/Current_User.dart';
import '../../Trending/trending_page.dart';

enum SampleItem {
  logout,
  profile,
  uploadNovel,
  bookmarked,
  //uploaded,
}

class SimpleAppBarPage extends StatefulWidget {
  const SimpleAppBarPage({super.key});

  @override
  _SimpleAppBarPageState createState() => _SimpleAppBarPageState();
}

class _SimpleAppBarPageState extends State<SimpleAppBarPage> {
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

  final FirebaseAuth auth = FirebaseAuth.instance;
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

  String getUID() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid!;
    // here you write the codes to input the data into firestore
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

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("Users").doc(uID).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  //title: const Text(MyApp.title),
                  //centerTitle: true,
                  // leading: IconButton(
                  //   icon: Icon(Icons.menu),
                  //   onPressed: () {},
                  // ),
                  title: Image.asset(
                    'assets/images/1.png',
                    height: 30,
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Text(
                        '${snapshot.data!['fullname']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    PopupMenuButton<SampleItem>(
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
                        } else if (selectedItem == SampleItem.profile) {
                          Navigator.of(context).pushNamed(Routes.PROFILE);
                        } else if (selectedItem == SampleItem.uploadNovel) {
                          Navigator.of(context).pushNamed(Routes.ADD_NOVEL);
                        } else if (selectedItem == SampleItem.bookmarked) {
                          Navigator.of(context).pushNamed(Routes.BOOKMARKED);
                        }
                        // else if (selectedItem == SampleItem.uploaded) {
                        //   Navigator.of(context).pushNamed(Routes.UPLOADED);
                        // }
                      },
                      //icon: const Icon(CupertinoIcons.bars),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<SampleItem>>[
                        const PopupMenuItem<SampleItem>(
                          value: SampleItem.logout,
                          child: Text('Log out'),
                        ),
                        const PopupMenuItem<SampleItem>(
                          value: SampleItem.profile,
                          child: Text('Profile'),
                        ),
                        const PopupMenuItem<SampleItem>(
                          value: SampleItem.uploadNovel,
                          child: Text('Upload Novel'),
                        ),
                        const PopupMenuItem<SampleItem>(
                          value: SampleItem.bookmarked,
                          child: Text('Favorite'),
                        ),
                        // const PopupMenuItem<SampleItem>(
                        //   value: SampleItem.uploaded,
                        //   child: Text('Uploaded novels'),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.search),
                    //   onPressed: () {},
                    // )
                  ],
                  backgroundColor: Colors.transparent,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: [Colors.purple, kPrimaryLightColor],
                      //   begin: Alignment.bottomRight,
                      //   end: Alignment.topLeft,
                      // ),
                      color: kPrimaryColor,
                    ),
                  ),
                  bottom: const TabBar(
                    //isScrollable: true,
                    indicatorColor: Colors.white,
                    indicatorWeight: 2,

                    tabs: [
                      Tab(icon: Icon(Icons.home), text: 'Home'),
                      Tab(icon: Icon(Icons.star), text: 'Trending'),
                      Tab(icon: Icon(Icons.face), text: 'Uploaded'),
                      // Tab(
                      //     icon: Icon(CupertinoIcons.heart_fill),
                      //     text: 'Favourite'),
                      Tab(icon: Icon(Icons.search), text: 'Search'),
                    ],
                  ),
                  elevation: 10,
                  titleSpacing: 20,
                ),
                body: const TabBarView(
                  children: [
                    HomePage(),
                    TrendingPage(),
                    UploadNovelScreen(),
                    //BookmarkScreen(),
                    HeaderSearchScreen(),
                  ],
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      backgroundColor: kPrimaryColor,
                      color: Colors.white,
                    )),
              );
            }
          },
        ),
      );

  Widget buildPage(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 28),
      ),
    );
  }
}
