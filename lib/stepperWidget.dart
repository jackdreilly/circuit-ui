import 'package:flutter/material.dart';

import 'constants.dart';

class StepperWidget extends StatelessWidget {
  final int step;

  const StepperWidget({Key key, this.step}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Stepper"),
      Row(
        children: List.generate(
            nSteps,
            (i) => Container(
                  decoration: BoxDecoration(
                      color: i == step ? Colors.red : Colors.grey),
                  child: Text(i.toString()),
                )),
      )
    ]);
  }
}