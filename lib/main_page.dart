import 'package:ed_proj/board_page.dart';
import 'package:ed_proj/map_page.dart';
import 'package:ed_proj/timetable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("광운대학교", style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: Color(0xff77212c),
      ),
      body: TimeTable(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 7,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xff2b2b2b),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.settings, color: Colors.white)),
                        Row(
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.logout, color: Colors.white)),
                          ],
                        )
                      ]),
                )),
            ExpansionTile(
              trailing: Icon(Icons.add),
              title: Text("학교 정보"),
              children: <Widget>[
                ExpansionTile(
                  trailing: Icon(Icons.add),
                  title: Text("시설 안내"),
                  children: <Widget>[
                    ListTile(
                      title: Text('내 강의실 찾기'),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        child: Text(
                                          "정문에서 출발",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffffffff)),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => MapPage(start: "새빛 304")));
                                        },
                                      ),
                                      SizedBox(height: 40),
                                      TextButton(
                                        child: Text("후문에서 출발",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xffffffff))),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => MapPage(start: "새빛 304")));
                                        },
                                      ),
                                    ],
                                  ));
                            });

                      },
                    ),
                    ListTile(title: Text('과 사무실')),
                    ListTile(title: Text('교내 식당')),
                    ListTile(title: Text('서점')),
                    ListTile(title: Text('은행')),
                  ],
                ),
                ListTile(title: Text("주요 소식")),
              ],
            ),
            ExpansionTile(
              trailing: Icon(Icons.add),
              title: Text("강의 게시판"),
              children: <Widget>[],
            ),
            ExpansionTile(
              trailing: Icon(Icons.add),
              title: Text("홍보 게시판"),
              children: <Widget>[
                ListTile(title: Text("동아리 게시판"),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BoardPage()));
                },),
                ListTile(title: Text("팀원 게시판"))
              ],
            ),
            ListTile(title: Text("자유 게시판")),
          ],
        ),
      ),
    );
  }
}
