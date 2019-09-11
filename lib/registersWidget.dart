import 'package:flutter/material.dart';

import 'registerWidget.dart';

class RegistersWidget extends StatelessWidget {
  final List<int> registers;
  final Set<int> enabled;

  const RegistersWidget({Key key, this.registers, this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: registers
            .asMap()
            .map((i, r) => MapEntry(
                i,
                RegisterWidget(
                  value: r,
                  isActive: enabled.contains(i),
                )))
            .values
            .toList());
  }
}