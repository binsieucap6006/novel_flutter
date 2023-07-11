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
import 'package:novel_flutter/screens/Profile/change_pw_screen.dart';
import 'package:novel_flutter/screens/Profile/delete_account_screen.dart';
import '../../models/userModel.dart';
import '../../states/Current_User.dart';
import 'components/appbar_widget.dart';
import 'components/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  Future<String> getFullname(String uID, String path) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(uID);
    var snapshot = await documentReference.get();
    fullnameTxt = snapshot[path];
    return fullnameTxt;
  }

  updateProfile() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    //print('${file?.path}');

    if (file == null) return;
    //Import dart:core
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    /*Step 2: Upload to Firebase storage*/
    //Install firebase_storage
    //Import the library

    //Get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('avt');

    //Create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //Handle errors/success
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(file.path));
      //Success: get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Upload success!')));
    } catch (error) {
      //print(error);
    }
    Map<String, dynamic> dataToSend = {
      'rqimg': imageUrl,
    };
    //Add a new item
    try {
      _reference.add(dataToSend).then(
        (DocumentReference doc) async {
          //print(doc.id);
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUid)
              .update({'img': imageUrl});
        },
      );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Novel created.')));
    } catch (e) {}
  }

  Future<void> deleteUserAuth(String currentPassword) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final cred = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!, password: currentPassword);
    _auth.currentUser!.reauthenticateWithCredential(cred).then((value) {
      _auth.currentUser!.delete().then((value) async {
        await CurrentUser().signOutUser();
        Navigator.of(context).pushNamed(Routes.WELCOME);
      });
    });
    await _auth.currentUser!.delete();
    //route();
    deleteUser();
    CurrentUser().signOutUser();
    Navigator.of(context).pushNamed(Routes.WELCOME);
  }

  deleteUser() {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;

      var userRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(_auth.currentUser!.uid)
          .delete();
    } catch (e) {}
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
  TextEditingController _profileFullnameController = TextEditingController();
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
      getFullname(getUID(), 'fullname'),
      getEmail(getUID(), 'email'),
    ]);
    _profileEmailController = TextEditingController(text: emailTxt);
    _profileFullnameController = TextEditingController(text: fullnameTxt);
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
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'Are you sure',
                                style: TextStyle(color: Colors.grey),
                              ),
                              content: const Text(
                                  'You want to change your profile picture?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    updateProfile();
                                    Navigator.of(context)
                                        .pushNamed(Routes.PROFILE);
                                  },
                                  child: Text(
                                    'Change it',
                                    style: TextStyle(
                                        color: Colors.red.withOpacity(0.8)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
                                  'Full name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _profileFullnameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {},
                              child: ElevatedButton(
                                onPressed: () async {
                                  String newName =
                                      _profileFullnameController.text;
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(getUID())
                                      .update({'fullname': newName});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Name changed"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: Text('Change Full name'.toUpperCase()),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {},
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePasswordPage()),
                                  );
                                },
                                child: Text('Change password'.toUpperCase()),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DeleteAccountPage()),
                                  );
                                },
                                child: Text('Delete account'.toUpperCase()),
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
                return Center(
                    child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ));
              }
            }),
      ),
    );
  }

  // Widget buildName(UserModel user) => Column(
  //       children: [
  //         Text(
  //           user.fullName!,
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //         ),
  //         const SizedBox(height: 4),
  //         Text(
  //           user.email!,
  //           style: TextStyle(color: Colors.grey),
  //         )
  //       ],
  //     );

  // Widget buildUpgradeButton() => ButtonWidget(
  //       text: 'Upgrade To PRO',
  //       onClicked: () {},
  //     );

  // Widget buildAbout(User user) => Container(
  //       padding: EdgeInsets.symmetric(horizontal: 48),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'About',
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 16),
  //           Text(
  //             user.about,
  //             style: TextStyle(fontSize: 16, height: 1.4),
  //           ),
  //         ],
  //       ),
  //     );
}
