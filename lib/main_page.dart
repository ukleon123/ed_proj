import 'package:ed_proj/board_page.dart';
import 'package:ed_proj/map_page.dart';
import 'package:ed_proj/timetable.dart';
import 'package:ed_proj/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MainPage extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> userData;

  MainPage({super.key, required this.userId, required this.userData});

  @override
  State<MainPage> createState() => _MainPageState(
      userId, userData['atnlcSbjectList'], userData['timeTableList']);
}

class _MainPageState extends State<MainPage> {
  final String userId;
  final List<dynamic> subjData;
  final List<dynamic> tableData;

  _MainPageState(this.userId, this.subjData, this.tableData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 80),
            child:
                Text("광운대학교", style: TextStyle(fontWeight: FontWeight.w900))),
        backgroundColor: Color(0xff77212c),
      ),
      body: TimeTable(tableData: tableData),
      drawer: buildDrawer(),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
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
                          Text(userId, style: TextStyle(color: Colors.white)),
                          Text(
                            "  Logout",
                            style: TextStyle(color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
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
                  ExpansionTile(
                      trailing: Icon(Icons.add),
                      title: Text("학교 건물"),
                      children: <Widget>[
                        ExpansionTile(
                            trailing: Icon(Icons.add),
                            title: Text("새빛관"),
                            children: <Widget>[
                              mapTile('1층'),
                              mapTile('2층'),
                              mapTile('3층'),
                              mapTile('4층'),
                              mapTile('5층'),
                              mapTile('6층'),
                              mapTile('7층'),
                              mapTile('8층'),
                              mapTile('9층'),
                            ]),
                        ExpansionTile(
                            trailing: Icon(Icons.add),
                            title: Text("비마관"),
                            children: <Widget>[
                              ExpansionTile(
                                  trailing: Icon(Icons.add), title: Text('1층')),
                              ExpansionTile(
                                  trailing: Icon(Icons.add), title: Text('2층')),
                              ExpansionTile(
                                  trailing: Icon(Icons.add), title: Text('3층')),
                              ExpansionTile(
                                  trailing: Icon(Icons.add), title: Text('4층')),
                              ExpansionTile(
                                  trailing: Icon(Icons.add), title: Text('5층')),
                              ExpansionTile(
                                  trailing: Icon(Icons.add),
                                  title: Text('6층'),
                                  children: [
                                    mapTile('비마601'),
                                    mapTile('비마602'),
                                    mapTile('비마604'),
                                    mapTile('비마605'),
                                    mapTile('비마606'),
                                    mapTile('비마607'),
                                    mapTile('비마608'),
                                    mapTile('비마609'),
                                    mapTile('비마612'),
                                    mapTile('비마613'),
                                    mapTile('비마614'),
                                    mapTile('비마615'),
                                    mapTile('비마616'),
                                    mapTile('비마617'),
                                  ]),
                              ExpansionTile(
                                  trailing: Icon(Icons.add), title: Text('7층')),
                              ExpansionTile(
                                  trailing: Icon(Icons.add), title: Text('8층')),
                              ExpansionTile(
                                  trailing: Icon(Icons.add), title: Text('9층')),
                            ]),
                        ExpansionTile(
                            trailing: Icon(Icons.add),
                            title: Text("80주년 기념관"),
                            children: <Widget>[
                              mapTile('지하 1층'),
                              mapTile('1층'),
                              mapTile('2층'),
                              mapTile('3층'),
                              mapTile('4층'),
                            ]),
                        ExpansionTile(
                            trailing: Icon(Icons.add),
                            title: Text("참빛관"),
                            children: <Widget>[
                              mapTile('지하 1층'),
                              mapTile('1층'),
                              mapTile('2층'),
                              mapTile('3층'),
                              mapTile('4층'),
                              mapTile('5층'),
                              mapTile('6층'),
                              mapTile('7층'),
                              mapTile('8층'),
                              mapTile('9층'),
                              mapTile('10층')
                            ]),
                        ExpansionTile(
                            trailing: Icon(Icons.add),
                            title: Text("누리관"),
                            children: <Widget>[
                              mapTile('1층'),
                              mapTile('2층'),
                              mapTile('3층'),
                              mapTile('4층'),
                              mapTile('5층'),
                            ]),
                        ExpansionTile(
                            trailing: Icon(Icons.add),
                            title: Text("한울관"),
                            children: <Widget>[
                              mapTile('지하 1층'),
                              mapTile('1층'),
                              mapTile('2층'),
                              mapTile('3층'),
                              mapTile('4층'),
                              mapTile('5층'),
                              mapTile('6층'),
                              mapTile('7층'),
                            ]),
                        ExpansionTile(
                            trailing: Icon(Icons.add),
                            title: Text("연구관"),
                            children: <Widget>[
                              mapTile('지하 1층'),
                              mapTile('1층'),
                              mapTile('2층'),
                              mapTile('3층'),
                              mapTile('4층'),
                            ]),
                        ExpansionTile(
                            trailing: Icon(Icons.add),
                            title: Text("옥의관"),
                            children: <Widget>[
                              mapTile('지하 1층'),
                              mapTile('1층'),
                              mapTile('2층'),
                              mapTile('3층'),
                              mapTile('4층'),
                              mapTile('5층'),
                              mapTile('6층'),
                              mapTile('7층'),
                              mapTile('8층'),
                              mapTile('9층'),
                            ]),
                      ]),
                  mapTile('과 사무실'),
                  mapTile('교내 식당'),
                  mapTile('서점'),
                  mapTile('은행'),
                ],
              ),
              ListTile(title: Text("주요 소식")),
            ],
          ),
          ExpansionTile(
            trailing: Icon(Icons.add),
            title: Text("강의 게시판"),
            children: lectureList(subjData),
          ),
          ExpansionTile(
            trailing: Icon(Icons.add),
            title: Text("홍보 게시판"),
            children: <Widget>[
              boardTile("club", "동아리"),
              boardTile("team", "팀원"),
            ],
          ),
          boardTile("free", "자유")
        ],
      ),
    );
  }

  List<Widget> lectureList(List<dynamic> subject) {
    final logger = Logger();
    List<Widget> lecture = [];
    for (dynamic data in subject) {
      lecture.add(boardTile(data['subj'], data['subjNm']));
    }
    return lecture;
  }

  Widget boardTile(String id, String name) {
    return ListTile(
        title: Text("$name 게시판"),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BoardPage(
                        boardId: id,
                        boardName: name,
                        userNo: userId,
                      )));
        });
  }

  Widget mapTile(String location) {
    return ListTile(
      title: Text(location),
      onTap: () {
        mapDialog(context, location);
      },
    );
  }
}
