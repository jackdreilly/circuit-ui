import 'package:flutter/material.dart';

import 'cpuPage.dart';
import 'infoWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'QuikCircuit',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: "Courier",
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Row(children: [
              Text('QuikCircuit CPU Simulator'),
              Padding(padding: EdgeInsets.only(left: 20), child: InfoWidget()),
            ]),
          ),
          body: CpuPage(),
        ));
  }
}
