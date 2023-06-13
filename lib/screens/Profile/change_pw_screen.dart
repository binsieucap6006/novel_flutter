import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:novel_flutter/components/background.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/routes/routes.dart';
import '../../models/userModel.dart';
import '../../states/Current_User.dart';
import 'components/appbar_widget.dart';
import 'components/profile_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({super.key, required});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String getUID() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid!;
    // here you write the codes to input the data into firestore
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  String emailTxt = '';
  String fullnameTxt = '';
  Future<String> getEmail(String uID, String path) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(uID);
    var snapshot = await documentReference.get();
    emailTxt = snapshot[path];
    return emailTxt;
  }

  Future<void> handleRefresh() async {
    try {
      return await Future.delayed(
        const Duration(seconds: 1),
      );
    } on Exception catch (e) {}
  }

  String imageUrl = '';
  String currentUid = '';
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Users');
  TextEditingController _profileEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  TextEditingController _newPasswordController = TextEditingController();

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      try {
        final cred = EmailAuthProvider.credential(
            email: user!.email!, password: currentPassword);
        try {
          user.reauthenticateWithCredential(cred).then((value) {
            try {
              user.updatePassword(newPassword).then((value) async {
                await CurrentUser().signOutUser();
                Navigator.of(context).pushNamed(Routes.WELCOME);
              });
            } catch (e) {}
          });
        } catch (e) {}
      } catch (e) {}
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getUID();
    currentUid = getUID();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    getUID();
    currentUid = getUID();
    //getUser();

    await Future.wait([
      getEmail(getUID(), 'email'),
    ]);
    _profileEmailController = TextEditingController(text: emailTxt);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return LiquidPullToRefresh(
                  color: kPrimaryColor,
                  onRefresh: () {
                    setState(() {});
                    return handleRefresh();
                  },
                  child: ListView(
                    //physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // Center(
                      //     child: Text(
                      //   'Profile page',
                      //   style: TextStyle(
                      //     fontSize: 30,
                      //     fontWeight: FontWeight.bold,
                      //     color: kPrimaryColor,
                      //   ),
                      // )),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      ProfileWidget(
                        imagePath: '${snapshot.data!['img']}',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      //buildName(),
                      Column(
                        children: [
                          Text(
                            '${snapshot.data!['fullname']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${snapshot.data!['email']}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      //const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  readOnly: true,
                                  controller: _profileEmailController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       'Confirm Password',
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 16),
                            //     ),
                            //     const SizedBox(height: 10),
                            //     TextFormField(
                            //       //controller: _profileFullnameController,
                            //       decoration: InputDecoration(
                            //         border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(12),
                            //         ),
                            //       ),
                            //       maxLines: 1,
                            //     ),
                            //   ],
                            // ),
                            //const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'New password',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  obscureText: true,
                                  controller: _newPasswordController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            InkWell(
                              onTap: () {},
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text(
                                        'Are you sure',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      content:
                                          const Text('You will be logged out!'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (_passwordController == '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Type your password"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            } else if (_newPasswordController ==
                                                '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Type your new password"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            } else {
                                              try {
                                                String oldPass =
                                                    _passwordController.text;
                                                String newPass =
                                                    _newPasswordController.text;

                                                changePassword(
                                                    oldPass, newPass);
                                              } catch (e) {}
                                            }
                                          },
                                          child: Text(
                                            'Change my password',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red
                                                    .withOpacity(0.8)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text('Change password'.toUpperCase()),
                              ),
                            ),

                            const SizedBox(height: 10),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       'Confirm password',
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 16),
                            //     ),
                            //     const SizedBox(height: 8),
                            //     TextFormField(
                            //       obscureText: true,
                            //       //readOnly: true,
                            //       controller: _profileEmailController,
                            //       decoration: InputDecoration(
                            //         border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(12),
                            //         ),
                            //       ),
                            //       maxLines: 1,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     print(_profileEmailController);
                      //     print(_profileFullnameController);
                      //     print(currentUid);
                      //   },
                      //   child: Text("submit"),
                      // ),
                      // Center(
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       if (_profileFullnameController.text == '' ||
                      //           _profileEmailController.text == '') {
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           const SnackBar(
                      //             content: Text(
                      //                 "Your email or full name can't be blank"),
                      //             duration: Duration(seconds: 2),
                      //           ),
                      //         );
                      //       } else {
                      //         //Navigator.of(context).pushNamed("/");
                      //       }
                      //     },
                      //     child: Text(
                      //       "Submit".toUpperCase(),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 24),
                      // TextFieldWidget(
                      //   label: 'About',
                      //   text: user.about,
                      //   maxLines: 5,
                      //   onChanged: (about) {},
                      // ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
