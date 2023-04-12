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
        title: const Padding(
            padding: EdgeInsets.only(left: 75), child: Text("광운대학교")),
        backgroundColor: Color(0xff77212c),
      ),
      body: Container(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
                height: 100,
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
              ],
            ),
            ExpansionTile(
              trailing: Icon(Icons.add),
              title: Text("시설 안내"),
              children: <Widget>[
                ListTile(title: Text('내 강의실 찾기')),
                ListTile(title: Text('과 사무실')),
                ListTile(title: Text('교내 식당')),
                ListTile(title: Text('서점')),
                ListTile(title: Text('은행')),
              ],
            ),
            ExpansionTile(
              trailing: Icon(Icons.add),
              title: Text("자유 게시판"),
              children: <Widget>[
              ],
            ),
            ExpansionTile(
              trailing: Icon(Icons.add),
              title: Text("강의 게시판"),
              children: <Widget>[
              ],
            ),
            ExpansionTile(
              trailing: Icon(Icons.add),
              title: Text("홍보 게시판"),
              children: <Widget>[
              ],
            ),
            ExpansionTile(
              trailing: Icon(Icons.add),
              title: Text("주요 소식"),
              children: <Widget>[
              ],
            ),
          ],
        ),
      ),
    );
  }
}
