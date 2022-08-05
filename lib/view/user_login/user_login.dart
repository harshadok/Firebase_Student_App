import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Createpage extends StatelessWidget {
  Createpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    List images = ["g.png", "t.png", "f.png"];
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
                  child: TextField(
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
                  child: TextField(
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
          const SizedBox(
            height: 50,
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
                  Navigator.of(context).pushNamed("welcome");
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
                  backgroundImage: AssetImage("img/" + images[index]),
                ),
              ),
            );
          }))
        ],
      ),
    );
  }
}
