import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ligin page"),
      ),
      body: Column(
        children: [
          Text("HI"),
          Text("New Version 4")
        ],
      ),
    );
  }
}