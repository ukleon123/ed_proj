
import 'package:flutter/material.dart';

import 'map_page.dart';

void mapDialog(BuildContext context, String location) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text(
                "정문에서 출발",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff)),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapPage(start: "정문", end: location)));
              },
            ),
            SizedBox(height: 40),
            TextButton(
              child: const Text("후문에서 출발",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff))),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapPage(start: "후문", end: location)));
              },
            ),
          ],
        ));
      });
}
