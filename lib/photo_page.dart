import 'package:ed_proj/data.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PhotoPage extends StatefulWidget {
  final String direction;
  final String destination;

  const PhotoPage({super.key, required this.direction, required this.destination});

  @override
  State<PhotoPage> createState() => _PhotoPageState(direction, destination);
}

class _PhotoPageState extends State<PhotoPage> {
  int count = 0;
  final logger = Logger();
  final String direction;
  final String destination;

  _PhotoPageState(this.direction, this.destination);

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery
        .of(context)
        .size
        .width;
    double fullHeight = MediaQuery
        .of(context)
        .size
        .height;

    int photoNum = photoData['Bma']['6f'][direction][destination];

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
            margin: EdgeInsets.only(left: 110),
              child: Text(destination)
          )
      ),
      body: Container(
          width: fullWidth,
          height: fullHeight * 8 / 10,
          child: Image.asset("asset/photo/Bma/6f/$direction/$destination/${count + 1}${(direction == "front")? ".jpg" : ".png"}")),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      count = (count - 1) % photoNum;
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios)
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      count = (count + 1) % photoNum;
                    });
                  },
                  icon: Icon(Icons.arrow_forward_ios)
              )
            ],
          )
      ),
    );
  }

}