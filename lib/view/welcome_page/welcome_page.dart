import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Scaffold(
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
              children: const [
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Welcome",
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            "hars@gmail.com",
            style: TextStyle(fontSize: 15, color: Colors.grey[500]),
          ),
          const SizedBox(
            height: 200,
          ),
          Container(
            width: width * 0.5,
            height: hight * 0.08,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                    image: AssetImage("img/logintab2.png"), fit: BoxFit.cover)),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("Signout");
                },
                child: const Text(
                  "Sign out",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: width * 0.15),
          SizedBox(
            height: width * 0.08,
          ),
        ],
      ),
    );
  }
}
