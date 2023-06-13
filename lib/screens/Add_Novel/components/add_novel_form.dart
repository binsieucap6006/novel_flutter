import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AddNovelForm extends StatefulWidget {
  const AddNovelForm({
    super.key,
  });

  //String novelId;
  @override
  State<StatefulWidget> createState() {
    return _AddNovelFormState();
  }
}

class _AddNovelFormState extends State<AddNovelForm> {
  String? errorMsg;
  //bool isLogin = false;
  final TextEditingController _novelNameController = TextEditingController();
  final TextEditingController _novelDescriptionController =
      TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Requests');
  String? selectedGenre = 'Action';
  String imageUrl = '';
  String rqID = '';
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUID() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid!;
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
            child: DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
                //disabledItemFn: (String s) => s.startsWith('I'),
              ),
              items: const [
                "Action",
                "Fantasy",
                "Sci-Fi",
                'Romance',
                'Slice of Life'
              ],
              dropdownDecoratorProps: const DropDownDecoratorProps(),
              onChanged: (value) {
                setState(() {
                  selectedGenre = value;
                });
              },
              selectedItem: selectedGenre,
            ),
          ),

          // DropdownSearch<String>.multiSelection(
          //   items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
          //   popupProps: PopupPropsMultiSelection.menu(
          //     showSelectedItems: true,
          //     disabledItemFn: (String s) => s.startsWith('I'),
          //   ),
          //   onChanged: print,
          //   selectedItems: ["Brazil"],
          // ),
          IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                //print('${file?.path}');

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
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Upload success!')));
                } catch (error) {
                  //print(error);
                }
              },
              icon: const Icon(Icons.camera_alt)),
          ElevatedButton(
            onPressed: () async {
              if (imageUrl.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please upload an image')));
                return;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Submit success!')));
                Navigator.of(context).pushNamed("/");
              }
              String uniqueFileName =
                  DateTime.now().millisecondsSinceEpoch.toString();
              String novelName = _novelNameController.text;
              String novelDescription = _novelDescriptionController.text;
              //Create a Map of data
              Map<String, dynamic> dataToSend = {
                'rqname': novelName,
                'rqdescription': novelDescription,
                'rqimg': imageUrl,
                'rqaction': "0",
                'rquser': getUID(),
                'rqgenre': selectedGenre!,
                'time': int.parse(uniqueFileName),
                'chapterNum': 0,
                'viewcount': 0
              };
              //Add a new item
              try {
                _reference.add(dataToSend).then(
                  (DocumentReference doc) async {
                    rqID = doc.id;
                    //print(doc.id);
                    await FirebaseFirestore.instance
                        .collection("Requests")
                        .doc(rqID)
                        .update({'rqid': rqID});
                  },
                );
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Novel created.')));
              } catch (e) {}
            },
            child: const Text('Submit'),
          ),
          const SizedBox(height: defaultPadding / 2),
        ],
      ),
    );
  }
}
