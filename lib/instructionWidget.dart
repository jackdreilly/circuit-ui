import 'package:flutter/material.dart';

import 'instruction.dart';
import 'registerWidget.dart';

class InstructionWidget extends StatelessWidget {
  final Instruction instruction;

  const InstructionWidget({Key key, this.instruction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Text(instruction.interpretation),
            RegisterWidget(
              value: instruction.value,
            ),
          ],
        )
      ],
    ));
  }
}