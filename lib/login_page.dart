import 'package:ed_proj/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Image.asset("logo/login_logo.png"), loginForm()],
    );
  }

  Future? login(String id, String pw) {
    Map<String, String> data = {"loginId": id, "loginPwd": pw};
    return null;
  }

  Container loginForm() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.8,
        height: MediaQuery.of(context).size.height / 4,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextFormField(
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(90)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(90)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      hintText: 'ID'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(90)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(90)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      hintText: 'PW'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                    },
                    child: const Text("로그인",
                        style: TextStyle(
                            color: Color(0xff77212c),
                          fontSize: (17),
                          fontWeight: FontWeight.w600
                        )
                    )
                )
              ],
            )
        )
    );
  }
}
