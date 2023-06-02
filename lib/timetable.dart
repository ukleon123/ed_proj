import 'package:ed_proj/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'map_page.dart';

class TimeTable extends StatefulWidget {
  final List<dynamic> tableData;

  const TimeTable({super.key, required this.tableData});

  @override
  State<TimeTable> createState() => _TimeTable(tableData);
}

class _TimeTable extends State<TimeTable> {
  final logger = Logger();
  final List<dynamic> tableData;
  final double tableWidth = 350;
  final double tableHeight = 700;

  _TimeTable(this.tableData);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20),
        width: tableWidth,
        height: tableHeight,
        child: buildTable(tableData));
  }

  Table buildTable(List<dynamic> tableData) {
    List<TableRow> table = [];
    table.add(addWeek());
    for (dynamic data in tableData) {
      List<Widget> row = [];
      for (int i = 1; i < 7; i++) {
        if (data['wtSpan_$i'] != null) {
          row.add(TableCell(
              child: GestureDetector(
                  onTap: () {
                    mapDialog(context, data['wtLocHname_$i']);
                  },
                  child: Container(
                      width: tableWidth / 7,
                      height: tableHeight / 8,
                      alignment: Alignment.topCenter,
                      color: Colors.orange,
                      child: Text(
                          "${data['wtSubjNm_$i']}\n${data['wtLocHname_$i']}",
                          style: TextStyle(fontSize: 13))))));
        } else {
          row.add(Container(
            width: tableWidth / 7,
            height: tableHeight / 8,
          ));
        }
      }
      table.add(TableRow(children: row));
    }
    return Table(
      children: table,
    );
  }

  TableRow addWeek() {
    List<String> dayWeek = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
    List<Widget> week = [];
    for (String day in dayWeek) {
      week.add(Container(
          width: tableWidth / 7,
          height: 20,
          alignment: Alignment.topCenter,
          child: Text(day, style: TextStyle(fontSize: 13))));
    }
    return TableRow(children: week);
  }
}
