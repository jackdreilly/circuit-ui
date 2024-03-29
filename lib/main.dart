import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ql/controls.dart';
import 'package:ql/cpuPage.dart';
import 'package:ql/infoWidget.dart';

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
          body: ChangeNotifierProvider<Controller>(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Stack(children: [CpuPage(), Loader()]),
              ),
              builder: (c) => Controller(c)),
        ));
  }
}

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    return StreamBuilder<bool>(
        stream: controller.loading,
        initialData: false,
        builder: (c, d) {
          return Center(
              child: d.data ? CircularProgressIndicator() : Container());
        });
  }
}
