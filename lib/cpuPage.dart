import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import 'compilerWidget.dart';
import 'constants.dart';
import 'simulation.dart' as sim;
import 'simulationState.dart';

class CpuPage extends StatefulWidget {
  final String title;

  CpuPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CpuPageState();
  }
}

class CpuPageState extends State<CpuPage> {
  socket_io.Socket socket;

  SimulationState state;

  bool beefy = false;

  @override
  void initState() {
    super.initState();
  }

  void onRun(String program) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Loading Program')));
    state = null;
    if (socket != null) {
      socket.disconnect();
    }
    socket = socket_io.io(socketAddress);
    socket.on('connect', (data) {
      socket.emit('json', json.encode({"program": program, "beefy": beefy}));
    });
    socket.on('json', (data) {
      Scaffold.of(context).hideCurrentSnackBar();
      state = SimulationState.fromJson(data);
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final compiler = CompilerWidget(onRun: onRun);
    final simulation = socket == null
        ? Column(children: [
            Text("Click Run To Start Simulation"),
            sim.Simulation.empty()
          ])
        : sim.Simulation(state: state);
    final beefySwitch = Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Text("Beefy Mode"),
            Switch(
              value: beefy,
              onChanged: (v) {
                setState(() {
                  beefy = v;
                });
              },
            ),
          ],
        ));
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(children: [
          Column(children: [simulation, beefySwitch]),
          compiler,
        ]));
  }
}
