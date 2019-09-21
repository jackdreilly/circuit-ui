import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ql/compilerWidget.dart';
import 'package:ql/controls.dart';
import 'package:ql/simulation.dart' as sim;
import 'package:ql/simulationState.dart';

class CpuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<Controller>(
      builder: (a, b, c) => StreamBuilder<SimulationState>(
          stream: b.simulations,
          initialData: SimulationState.empty(),
          builder: (c, d) {
            final controls = Controls();
            final simulation = sim.Simulation(state: d.data);
            final compiler = CompilerWidget();
            final top = controls;
            final bottom = Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[simulation, compiler],
                    ),
                  ),
                ),
                margin: EdgeInsets.all(10));
            return SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[top, bottom],
            ));
          }));
}
