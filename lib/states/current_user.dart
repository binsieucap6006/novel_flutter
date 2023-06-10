import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:novel_flutter/models/userModel.dart';

class CurrentUser extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  // UserModel? userModel(User user) {
  //   return user != null ? UserModel(email: user.email, uid: user.uid) : null;
  // }

  Stream<User?> get authStateChange => _auth.authStateChanges();
  bool isLogin = false;
  Future<void> signUpUser(
      {required String email, required String password}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    //return isLogin = true;
  }

  Future<void> signOutUser() async {
    await _auth.signOut();
    //return isLogin = false;
  }
}
