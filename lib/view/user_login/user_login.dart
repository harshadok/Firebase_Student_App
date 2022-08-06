// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_firebase/view/login/login_screen.dart';
import 'package:studentapp_firebase/view_model/auth/auth_provider.dart';

import '../welcome_page/welcome_page.dart';
import '../wodgets/constan_widgets.dart';

// ignore: must_be_immutable
class Createpage extends StatefulWidget {
  const Createpage({Key? key}) : super(key: key);

  @override
  State<Createpage> createState() => _CreatepageState();
}

class _CreatepageState extends State<Createpage> {
  final TextEditingController email = TextEditingController(),
      passsword = TextEditingController();

  Future singUp(AuthProvider provider) async {
    final msg = await provider.signUp(email.text, passsword.text);

    if (msg == '') return;

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    final authProvider = context.watch<AuthProvider>();
    List images = ["g.png", "t.png", "f.png"];
    return StreamBuilder<User?>(
        stream: authProvider.stream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) return const WelcomePage();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Container(
                  width: width,
                  height: hight * 0.3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("img/creta_page2.png"),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: hight * 0.20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey[500],
                        radius: 40,
                        backgroundImage: const AssetImage("img/profile.png"),
                      )
                    ],
                  ),
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
                          controller: email,
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
                        child: TextFormField(
                          controller: passsword,
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()));
                        },
                        child: small_text_in_loginPage(
                          text: "login",
                        ),
                      ),
                      Expanded(child: Container()),
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
                          singUp(authProvider);
                          //Navigator.of(context).pushNamed("welcome");
                        },
                        child: const Text(
                          "Sign up",
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
                  text: "Sign up using one of the following methods",
                  style: TextStyle(color: Colors.grey[500], fontSize: 15),
                )),
                SizedBox(
                  height: width * 0.08,
                ),
                Wrap(
                    children: List<Widget>.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 18,
                        // ignore: prefer_interpolation_to_compose_strings
                        backgroundImage: AssetImage("img/" + images[index]),
                      ),
                    ),
                  );
                }))
              ],
            ),
          );
        });
  }
}
