import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:novel_flutter/states/Current_User.dart';
import 'package:provider/provider.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';

import '../../../routes/routes.dart';
import '../../Login/login_screen.dart';

class AddNovelForm extends StatefulWidget {
  const AddNovelForm({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddNovelFormState();
  }
}

class _AddNovelFormState extends State<AddNovelForm> {
  String? errorMsg;
  bool isLogin = false;
  final TextEditingController _novelNameController = TextEditingController();
  final TextEditingController _novelDescriptionController =
      TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('Requests');

  String imageUrl = '';
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? inputData() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _novelNameController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.book),
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the name';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _novelDescriptionController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Description",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.description),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }

                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              //controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Genre(s)",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                print('${file?.path}');

                if (file == null) return;
                //Import dart:core
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();

                /*Step 2: Upload to Firebase storage*/
                //Install firebase_storage
                //Import the library

                //Get a reference to storage root
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('img');

                //Create a reference for the image to be stored
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                //Handle errors/success
                try {
                  //Store the file
                  await referenceImageToUpload.putFile(File(file.path));
                  //Success: get the download URL
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (error) {}
              },
              icon: Icon(Icons.camera_alt)),
          ElevatedButton(
            onPressed: () async {
              if (imageUrl.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please upload an image')));
                return;
              }

              //if (key.currentState!.validate()) {
              String novelName = _novelNameController.text;
              String novelDescription = _novelDescriptionController.text;

              //Create a Map of data
              Map<String, String> dataToSend = {
                'rqname': novelName,
                'rqdescription': novelDescription,
                'rqimg': imageUrl,
                'rqaction': "0",
                'rquser': "1",
              };

              //Add a new item
              _reference.add(dataToSend);
              //}
            },
            child: Text('Submit'),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {},
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.of(context).pushNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
    );
  }
}
