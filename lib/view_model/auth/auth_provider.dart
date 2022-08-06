import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth fb;
  bool isloading = false;
  AuthProvider(this.fb);
  bool get loading => isloading;

  Stream<User?> stream() => fb.authStateChanges();

  Future<String> signIn(String email, String password) async {
    try {
      isloading = true;
      notifyListeners();
      await fb.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      isloading = false;
      notifyListeners();
      return Future.value("");
    } on FirebaseAuthException catch (ex) {
      isloading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }
}
