import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  late String uid;
  late String email;

  AuthModel({
    required this.uid,
    required this.email,
  });

  AuthModel.fromFirebaseUser({required User user}) {
    uid = user.uid;
    email = user.email!;
  }
}
