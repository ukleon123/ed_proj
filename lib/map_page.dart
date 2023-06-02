import 'dart:convert';

import 'package:ed_proj/photo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  final String start;
  final String end;

  const MapPage({super.key, required this.start, required this.end});

  @override
  State<MapPage> createState() => _MapPageState(start, end);
}

class _MapPageState extends State<MapPage> {
  final String start;
  final String end;
  final logger = Logger();
  final List<NLatLng> location = [
    NLatLng(37.6192404, 127.0581),
    NLatLng(37.6203, 127.0612),
    NLatLng(37.6197891, 127.0608986), //새빛관
    NLatLng(37.6196948, 127.0595829), //비마관
    NLatLng(37.6201269, 127.0588683), //도서관
    NLatLng(37.6192568, 127.060936), //참빛관
    NLatLng(37.6196948, 127.0595829), //서점
    NLatLng(37.6194467, 127.0577239), //은행
    NLatLng(37.619539500000094, 127.05836799999979), //식당
  ];

  _MapPageState(this.start, this.end);

  bool idx = true;
  List<String> mode = ["약도 보기", "지도 보기"];

  @override
  Widget build(BuildContext context) {
    List<String> imgPath = [
      "asset/map/Bma/6f/${(start == "정문") ? 'front' : 'back'}/6${end.substring(3)}.png",
      "asset/map/Bma/6f/${(start == "정문") ? 'front' : 'back'}/6${end.substring(3)}.png"
    ];
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
          title:
              Container(margin: EdgeInsets.only(left: 100), child: Text(end))),
      body: Container(
          width: fullWidth,
          height: fullHeight * 8 / 10,
          // child: Image.asset("logo/login_logo.png")
          child: FutureBuilder(
            future: bodyContent(idx, imgPath),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data;
              } else {
                return Container();
              }
            },
          )),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
        child: TextButton(
          style: TextButton.styleFrom(maximumSize: Size(100, 40)),
          child: Text(mode[idx ? 0 : 1],
              style: TextStyle(color: Color(0xff77212c))),
          onPressed: () {
            setState(() {
              idx = !idx;
            });
          },
        ),
      ),
    );
  }

  dynamic bodyContent(bool state, List<String> imgPath) async {
    int endIdx = 0;
    int startIdx = (start == "정문") ? 0 : 1;
    switch (end[0]) {
      case "새":
        endIdx = 2;
        break;
      case "비":
        endIdx = 3;
        break;
      case "8":
        endIdx = 4;
        break;
      case "참":
        endIdx = 5;
        break;
      case "서":
        endIdx = 6;
        break;
      case "은":
        endIdx = 7;
        break;
      case "교":
        endIdx = 8;
        break;
      case "과":
        endIdx = 2;
    }
    var logger = Logger();
    if (state) {
      Position tmp = await Geolocator.getCurrentPosition();
      NCameraPosition initLocation = NCameraPosition(
          target: NLatLng(tmp.latitude, tmp.longitude), zoom: 16.5);
      return NaverMap(
        onMapReady: (NaverMapController controller) async {
          NMarker start = NMarker(
              id: "출발",
              position: location[startIdx],
              caption: NOverlayCaption(text: '출발'));
          NMarker end = NMarker(
              id: "도착",
              position: location[endIdx],
              caption: NOverlayCaption(text: '도착'));
          NMultipartPath path =
              await getPath(location[startIdx], location[endIdx]);
          controller.addOverlay(start);
          controller.addOverlay(end);
          controller.addOverlay(NMultipartPathOverlay(id: "경로", paths: [path]));
        },
        options: NaverMapViewOptions(
          mapType: NMapType.basic,
          liteModeEnable: true,
          initialCameraPosition: initLocation,
        ),
      );
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                style: IconButton.styleFrom(
                  maximumSize: Size(20, 20),
                    minimumSize: Size(20, 20),
                    backgroundColor: Color(0xff77212c),
                    foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoPage(
                              direction: (start == "정문") ? 'front' : 'back',
                              destination: '6${end.substring(3)}')));
                },
                icon: Icon(Icons.camera_enhance),
                ),
            Image.asset(imgPath[startIdx]),
            SizedBox(height: 40)
          ]);
    }
  }

  Future<dynamic> getPath(NLatLng start, NLatLng end) async {
    String url =
        "https://map.naver.com/v5/api/dir/findwalk?lo=ko&st=1&o=all&l=${start.longitude},${start.latitude};${end.longitude},${end.latitude}&lang=ko";
    Map<dynamic, dynamic> resp =
        JsonDecoder().convert((await http.get(Uri.parse(url))).body);
    List<dynamic> route = resp['routes'][0]['legs'][0]['steps'];

    List<NLatLng> Path = [];
    for (int idx = 0; idx < route.length; idx++) {
      if (route[idx]['path'] != null) {
        List<String> path = route[idx]['path'].split(' ');
        for (int eIdx = 0; eIdx < path.length; eIdx++) {
          List<String> point = path[eIdx].split(',');
          Path.add(NLatLng(double.parse(point[1]), double.parse(point[0])));
        }
      }
    }
    return NMultipartPath(color: Colors.blue, coords: Path);
  }
}
