import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_firebase/view_model/auth/auth.dart';

import '../wodgets/constan_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: width,
            height: hight * 0.3,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/loginimg2.png"), fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    small_text_in_loginPage(
                      text: "Sing in to your account",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.5))
                      ],
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailController.text = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1.0, color: Colors.white),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.5))
                      ],
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    validator: (value) {
                      RegExp regexp = RegExp(r'^.{6,}$');
                      if (value == null || value.isEmpty) {
                        return ("Please Enter Your Password");
                      }
                      if (!regexp.hasMatch(value)) {
                        return ("Please Enter A Valide Password(min 6 Character)");
                      }
                      return null;
                    },
                    controller: passwordController,
                    onSaved: (value) {
                      passwordController.text = value!;
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1.0, color: Colors.white),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    small_text_in_loginPage(
                      text: "Forget your password",
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Consumer<AuthenticationService>(
            builder: (BuildContext context, signIn, Widget? child) {
              return Container(
                width: width * 0.5,
                height: hight * 0.08,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                        image: AssetImage("img/logintab2.png"),
                        fit: BoxFit.cover)),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      // if (formKey.currentContext != null) {

                      signIn.signIn(
                          contex: context,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());

                      //  }
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: width * 0.15),
          RichText(
            text: TextSpan(
                text: "Dont'n have an account?",
                style: TextStyle(color: Colors.grey[500], fontSize: 15),
                children: [
                  TextSpan(
                      text: "Create",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed("Create");
                        }),
                ]),
          )
        ],
      ),
    );
  }
}
