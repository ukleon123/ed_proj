import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (msg) {},
              validator: (msg) {
                return null;
              },
            ),
            TextFormField(
              onSaved: (msg) {},
              validator: (msg) {
                if (msg!.isEmpty) {
                  return "아이디를 입력해주세요";
                }
                else{
                  return null;
                }
              },
            ),
            ElevatedButton(onPressed: () {}, child: Text("Login"))
          ],
        ));
  }
}
