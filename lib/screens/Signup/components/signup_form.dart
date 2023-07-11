import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/models/userModel.dart';
import 'package:novel_flutter/states/Current_User.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';

import '../../../routes/routes.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpFormState();
  }
}

class _SignUpFormState extends State<SignUpForm> {
  String? errorMsg;
  bool isLogin = false;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  Future<bool> signUpUserAuth(
      {required String email, required String password}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return true;
  }

  Future<String?> signUpUser() async {
    try {
      if (await signUpUserAuth(
              email: _emailController.text,
              password: _passwordController.text) ==
          true) {
        addUser();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sign up success"),
            duration: Duration(seconds: 2),
          ),
        );
      }

      Navigator.of(context).pushNamed("/");
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please use password that have 6 or more words."),
            duration: Duration(seconds: 5),
          ),
        );
      } else if (e.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Wrong email format, your email should be examble@examble.com."),
            duration: Duration(seconds: 5),
          ),
        );
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email elready in use, please use another email."),
            duration: Duration(seconds: 5),
          ),
        );
      }
      setState(() {
        errorMsg = e.message;
      });
    }
    return currentUser?.uid;
  }

  Future<void> addUser() {
    return collectionReference
        .doc(getUID())
        .set(
          {
            'fullname': _fullNameController.text,
            'admin': false,
            'img':
                "https://firebasestorage.googleapis.com/v0/b/novelhovel-8a04e.appspot.com/o/avt%2F324337349_920142589000241_7555360052804976216_n.jpg?alt=media&token=dd34a3ff-ddda-404c-a32d-457fe2827547&_gl=1*z3c246*_ga*MTAwMzkzMTQwLjE2ODUwNjk1Njc.*_ga_CW55HF8NVT*MTY4NjMwODUwOC4xMy4xLjE2ODYzMTA1MDcuMC4wLjA.",
            'email': _emailController.text,
            'uid': getUID(),
          },
        )
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  GlobalKey<FormState> key = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Users");
  String getUID() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid!;
    // here you write the codes to input the data into firestore
  }

  late UserModel user;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.alternate_email),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _fullNameController,
              textInputAction: TextInputAction.done,
              //obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Full name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person_outline),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _confirmPasswordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Confirm password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              if (_passwordController.text != '' &&
                  _passwordController.text == _confirmPasswordController.text) {
                signUpUser();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Passwords do not match"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
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
