import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationService extends ChangeNotifier {
  validation(value) {
    {
      if (value!.isEmpty) {
        return ("Please Enter Your Email");
      }
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return ("Please Enter a valid email");
      }
      return null;
    }
  }

  Future signIn(
      {required String email, required String password, contex}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
          (uid) => {
            Fluttertoast.showToast(msg: "Login Succsess"),
            Navigator.pushNamed(contex, "SignIn")
          },
        )
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.massage);
    });
  }
}
