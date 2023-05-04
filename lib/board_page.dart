import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoardPage extends StatefulWidget {
  BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
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
            title: Text("게시판")),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: EdgeInsets.only(top: 60, left: 38, bottom: 20),
              child: Text(
                "게시판",
                style: TextStyle(fontSize: 20),
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
                // if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (context, idx) {
                      DateTime now = DateTime.now();
                      return Container(
                          margin: EdgeInsets.only(top: 5, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: fullWidth / 6),
                                  child: Text(idx.toString())),

                              Container(
                                  margin: EdgeInsets.only(left: fullWidth / 5),
                                  child: Text("${idx.toString()} 번 글입니다.")),
                              Container(
                                  margin:
                                      EdgeInsets.only(left: fullWidth / 4 - 30),
                                  child: Text("김김김")),
                              // Text(snapshot.data!['title']),
                              // Text(snapshot.data!['time']),
                            ],
                          ));
                    });
                // }
                // else {
                //   return Container();
                // }
              },
            ),
            Container(
                height: 1,
                width: fullWidth * 4 / 5,
                margin: EdgeInsets.only(top: 10),
                color: Colors.black),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                child: Text("1"),
                style: TextButton.styleFrom(minimumSize: Size(10, 10)),
                onPressed: () {},
              ),
              TextButton(
                child: Text("2"),
                style: TextButton.styleFrom(minimumSize: Size(10, 10)),
                onPressed: () {},
              ),
              TextButton(
                child: Text("3"),
                style: TextButton.styleFrom(minimumSize: Size(10, 10)),
                onPressed: () {},
              ),
              TextButton(
                child: Text("글쓰기"),
                onPressed: () {},
              )
            ]),
          ])),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: fullWidth / 2,
              child: TextField(
                style: TextStyle(fontSize: 15),
              ),
            ),
            TextButton(onPressed: () {}, child: Text("검색"))
          ])
        ])));
  }

  Future data() async {
    return null;
  }
}
