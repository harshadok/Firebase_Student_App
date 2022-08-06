import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import '../../model/registration_model/registration_model.dart';

class AddRegister extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  Future createUser(String email, String password) async {
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              postDetailsToFireStore(),
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.massage);
    });
  }

  postDetailsToFireStore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = auth.currentUser;

    // RegistarionModel userModel = RegistarionModel();
    // userModel.email = user!.email;
    // userModel.id = DateTime.now().microsecondsSinceEpoch.toString();

    // await firebaseFirestore
    //     .collection("regiter")
    //     .doc("user.id")
    //     .set(userModel.toMap());
  }
}
