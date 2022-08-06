import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_firebase/view/user_login/user_login.dart';
import 'package:studentapp_firebase/view_model/auth/auth_provider.dart';

import '../wodgets/constan_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future singIn(AuthProvider provider) async {
    final msg =
        await provider.signIn(emailController.text, passwordController.text);

    if (msg == '') return;

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    final authProvider = context.watch<AuthProvider>();

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
                  //email textfrom filed

                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Your eamil id",
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.orange,
                        ),
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
                  //password textfrom filed
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: "Your password",
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.orange,
                        ),
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
          if (authProvider.isloading)
            const CircularProgressIndicator(
              strokeWidth: 2,
            ),
          if (!authProvider.isloading)
            Container(
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
                    singIn(authProvider);
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Createpage()));
                        }),
                ]),
          )
        ],
      ),
    );
  }
}
