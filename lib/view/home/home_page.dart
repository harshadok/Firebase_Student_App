import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_firebase/view/login/login_screen.dart';
import 'package:studentapp_firebase/view_model/auth/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().stream(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) return LoginScreen();
          return const Text("hallo");
        }));
  }
}
