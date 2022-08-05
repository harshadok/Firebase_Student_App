import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class small_text_in_loginPage extends StatelessWidget {
  small_text_in_loginPage({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 17, color: Colors.grey[500]),
    );
  }
}
