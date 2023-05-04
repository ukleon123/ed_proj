import 'package:flutter/cupertino.dart';

class TimeTable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimeTable();
}

class _TimeTable extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 170,
        height: 170,
        child: Text("Table"));
  }
}
