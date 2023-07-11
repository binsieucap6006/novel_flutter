import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  // UserModel? userModel(User user) {
  //   return user != null ? UserModel(email: user.email, uid: user.uid) : null;
  // }
  Stream<User?> get authStateChange => _auth.authStateChanges();
  Future<bool> signUpUser(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOutUser() async {
    await _auth.signOut();
  }

  Future<void> deleteUser() async {
    await _auth.currentUser!.delete();
  }
}
