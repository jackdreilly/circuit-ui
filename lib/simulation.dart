import 'package:flutter/material.dart';

import 'constants.dart';
import 'flagsWidget.dart';
import 'instructionWidget.dart';
import 'ramWidget.dart';
import 'registerWidget.dart';
import 'registersWidget.dart';
import 'simulationState.dart';
import 'stepperWidget.dart';

class Simulation extends StatelessWidget {
  final SimulationState state;

  const Simulation({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == null) {
      return Column(children: [
        Text("Loading Your Program..."),
        Simulation.empty(),
      ]);
    }
    var ir = Column(children: [
      Text("IR Register"),
      InstructionWidget(instruction: state.ir),
    ]);
    var bus = Column(children: [
      Text("Bus"),
      InstructionWidget(instruction: state.bus),
    ]);
    var input = Column(children: [
      Text("Input"),
      InstructionWidget(instruction: state.input),
    ]);
    var output = Column(children: [
      Text("Output"),
      RegisterWidget(value: state.output),
    ]);
    var flags = FlagsWidget(
      flags: state.flags,
    );
    var stepper = StepperWidget(
      step: state.steps.step,
    );
    var registers = Column(
      children: <Widget>[
        Text("Registers"),
        RegistersWidget(
          registers: state.registers,
          enabled: state.enablers
              .where((e) => e.startsWith("R"))
              .map((e) => int.tryParse(e.substring(1)))
              .toSet(),
        ),
      ],
    );
    var leftCol = Container(
      child: Column(
        children: <Widget>[
          stepper,
          bus,
          ir,
          flags,
          registers,
          input,
          output,
        ]
            .map((w) => Container(
                  child: w,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  margin: EdgeInsets.all(padding),
                  padding: EdgeInsets.all(padding),
                ))
            .toList(),
      ),
      margin: EdgeInsets.all(padding),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    );
    var ram = RamWidget(ramData: state.ram, activeRegister: state.iar);
    var rightCol = Container(
        margin: EdgeInsets.all(padding),
        padding: EdgeInsets.all(padding),
        child: ram);
    return Container(
        margin: EdgeInsets.all(padding),
        padding: EdgeInsets.all(padding),
        child: Row(
          children: <Widget>[leftCol, rightCol],
        ));
  }

  factory Simulation.empty() {
    return Simulation(state: SimulationState.empty());
  }
}
