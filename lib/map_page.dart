import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, this.start});

  final start;

  @override
  State<MapPage> createState() => _MapPageState(start);
}

class _MapPageState extends State<MapPage> {
  _MapPageState(this.data);

  final data;

  bool idx = false;

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
          title: Text(data)),
      body: Container(
          width: fullWidth,
          height: fullHeight * 8 / 10,
          // child: Image.asset("logo/login_logo.png")
          child: FutureBuilder(
            future: bodyContent(idx),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
            TextButton(
              child: Text("사진 보기", style: TextStyle(color: Color(0xff77212c))),
              onPressed: () {
                if (!idx) {

                  setState(() {
                    idx = !idx;
                  });
                } else {
                  setState(() {
                    idx = !idx;
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  dynamic bodyContent(bool state) async {
    var logger = Logger();
    if (state) {
      // Position tmp = await Geolocator.getCurrentPosition();
      // NCameraPosition initLocation = NCameraPosition(target: NLatLng(tmp.latitude, tmp.longitude), zoom: 10);
      // logger.w(tmp);
      return NaverMap(
        options: NaverMapViewOptions(
          mapType: NMapType.navi,
          // initialCameraPosition: initLocation
        ),
      );
    } else {
      return Image.asset("logo/login_logo.png");
    }
  }
}
