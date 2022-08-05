import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextFormField(
              controller: nameController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                createUser(name: name);
              },
              child: const Text("add"))
        ],
      ),
    );
  }

  Future createUser({required name}) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc('my-id');

    final json = {
      'name': name,
      "agr": 24,
    };
    await docUser.set(json);
  }
}
