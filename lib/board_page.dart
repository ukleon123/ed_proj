import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ed_proj/board_content_page.dart';
import 'package:ed_proj/board_write_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BoardPage extends StatefulWidget {
  final String boardId;
  final String boardName;
  final String userNo;

  BoardPage(
      {super.key,
      required this.boardName,
      required this.boardId,
      required this.userNo});

  @override
  State<BoardPage> createState() => _BoardPageState(boardId, boardName, userNo);
}

class _BoardPageState extends State<BoardPage> {
  final String userNo;
  final String boardId;
  final String boardName;
  final database = FirebaseFirestore.instance;

  _BoardPageState(this.boardId, this.boardName, this.userNo);

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
                child: Text("$boardName 게시판"))),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: EdgeInsets.only(top: 60, left: 38, bottom: 20),
              child: Text(
                "$boardName 게시판",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )),
          Container(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("번호"),
                Text("제목"),
                Text("사용자"),
              ],
            ),
            FutureBuilder(
              future: data(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, idx) {
                        return Container(
                            margin:
                                EdgeInsets.only(top: 10, bottom: 5, left: 8),
                            child: GestureDetector(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Text('$idx'),
                                    ),
                                    Container(
                                      child: Text(snapshot.data[idx]['title']),
                                    ),
                                    Container(
                                      child: Text(snapshot.data[idx]['name']),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ContentPage(
                                                    title: snapshot.data[idx]
                                                        ['title'],
                                                    content: snapshot.data[idx]
                                                        ['context'],
                                                    writer: snapshot.data[idx]
                                                        ['name'],
                                                    boardName: boardName,
                                                  )))
                                      .then((value) => setState(() {}));
                                }));
                      });
                } else {
                  return Container();
                }
              },
            ),
            Container(
                height: 1,
                width: fullWidth * 4 / 5,
                margin: EdgeInsets.only(top: 10),
                color: Colors.black),
            Container(
                padding: EdgeInsets.only(left: fullWidth - 170, top: 20),
                child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(60, 30),
                    backgroundColor: Color(0xff77212c),
                  ),
                  child: Text(
                    "글 작성",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditingPage(
                                    boardId: boardId,
                                    boardName: boardName,
                                    userNo: userNo)))
                        .then((value) => setState(() {}));
                  },
                )),
          ])),
        ])));
  }

  Future data() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await database.collection(boardId).get();
    return data.docs;
  }
}
