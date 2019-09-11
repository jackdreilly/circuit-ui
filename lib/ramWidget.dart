import 'package:flutter/material.dart';

import 'ramData.dart';
import 'registerWidget.dart';

class RamWidget extends StatelessWidget {
  final RamData ramData;
  final int activeRegister;

  RamWidget({@required this.ramData, Key key, this.activeRegister})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (var i = 0; i < ramData.nRows(); i++) {
      List<Widget> row = [];
      for (var j = 0; j < ramData.nCols(); j++) {
        row.add(RegisterWidget(
            value: ramData.data[i][j], isActive: isActive(i, j)));
      }
      rows.add(Row(
        children: row,
      ));
    }
    return Container(
        child: Column(children: rows),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black), color: Colors.lightBlue));
  }

  bool isActive(int row, int col) {
    return (row * ramData.nCols() + col) == activeRegister;
  }

  Row createRow(List<int> registerValues) {
    return Row(
        children: registerValues
            .map((i) => RegisterWidget(
                  value: i,
                ))
            .toList(growable: false));
  }
}