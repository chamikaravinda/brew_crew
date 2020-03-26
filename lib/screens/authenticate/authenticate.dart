import 'package:brewcrew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authernticate extends StatefulWidget {
  @override
  _AuthernticateState createState() => _AuthernticateState();
}

class _AuthernticateState extends State<Authernticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}
