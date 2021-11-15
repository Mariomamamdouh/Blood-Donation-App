import 'package:flutter/material.dart';

class Simple extends StatefulWidget {
  final title;
  Simple(this.title);
  @override
  SimpleState createState() => SimpleState();
}

class SimpleState extends State<Simple> {
  Color g2 = Color.fromRGBO(93, 96, 99, 1);
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
        fontSize: 30,
        fontFamily: 'Arial',
        fontWeight: FontWeight.normal,
        color: g2,
      ),
    );
  }
}
