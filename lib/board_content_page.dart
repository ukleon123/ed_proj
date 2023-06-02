import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentPage extends StatefulWidget {
  ContentPage(
      {super.key,
      required this.title,
      required this.content,
      required this.writer,
      required this.boardName});

  final String title, content, writer, boardName;

  @override
  State<ContentPage> createState() =>
      _ContentPageState(title, content, writer, boardName);
}

class _ContentPageState extends State<ContentPage> {
  final String title, content, writer, boardName;
  final database = FirebaseFirestore.instance;

  _ContentPageState(this.title, this.content, this.writer, this.boardName);

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff77212c),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Container(
                margin: EdgeInsets.only(left: 80),
                child: Text("$boardName 게시글"))),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: EdgeInsets.only(left: 30, bottom: 10, top: 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: fullWidth * 4 / 5,
                      padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                        child: Text("$boardName | 전체",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600))),
                    SizedBox(height: 15),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text("[제목] $title",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600))),
                    Container(
                        margin: EdgeInsets.only(left: fullWidth - 150),
                        child: Text("작성자: $writer")),
                  ])),
          Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              margin: EdgeInsets.only(left: 30, bottom: 10, top: 10),
              width: fullWidth * 4 / 5,
              height: fullHeight / 2,
              decoration: BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide()),
              ),
              child: Text(content, style: TextStyle(fontSize: 17))),
          Container(
              margin: EdgeInsets.only(left: fullWidth - 130),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(80, 40),
                    backgroundColor: Color(0xff77212c),
                  ),
                  child: Text(
                    "목록",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )))
        ])));
  }
}
