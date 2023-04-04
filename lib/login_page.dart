import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage ({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Image.network("https://www.kw.ac.kr/ko/img/symbol01_01.jpg"),

        ]
      ),
      bottomNavigationBar: Row(),
    );
  }
  Future? login(String id, String pw) {

    return null;
  }
}