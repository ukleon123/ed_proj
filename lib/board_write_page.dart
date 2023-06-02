import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditingPage extends StatefulWidget {
  final String userNo;
  final String boardId;
  final String boardName;

  const EditingPage(
      {super.key, required this.boardId, required this.boardName, required this.userNo});

  @override
  State<EditingPage> createState() => _EditingPageState(boardId, boardName, userNo);
}

class _EditingPageState extends State<EditingPage> {
  final String userNo;
  final String boardId;
  final String boardName;
  final database = FirebaseFirestore.instance;

  _EditingPageState(this.boardId, this.boardName, this.userNo);

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

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
              child: Text("게시글 작성"))
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 30),
              child: Text(
                "$boardName 게시판",
                style: TextStyle(
                  fontSize:  20,
                  fontWeight: FontWeight.w700,
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, bottom: 20, top: 20),
              width: fullWidth * 4 / 5,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "제목",
                    isDense: true,
                    contentPadding: EdgeInsets.all(10)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 30),
                width: fullWidth * 4 / 5,
                height: fullHeight / 2,
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      hintText: "본문"),
                  maxLines: 15,
                )),
          ])),
      bottomNavigationBar: ElevatedButton(
          onPressed: () {
            database.collection(boardId).doc().set({
              "name": userNo,
              "title": titleController.text,
              "context": contentController.text
            });
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(fullWidth, 50),
            backgroundColor: Color(0xff77212c),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          ),
          child: Text("글 작성")),
    );
  }
}
