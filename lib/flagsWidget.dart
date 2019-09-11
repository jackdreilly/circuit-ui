import 'package:flutter/material.dart';
import 'package:queries/collections.dart';

import 'flagWidget.dart';
import 'flags.dart';

class FlagsWidget extends StatelessWidget {
  final Flags flags;

  const FlagsWidget({Key key, this.flags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Flags"),
        Row(
            children: Collection(flags.values.keys.toList())
                .orderBy((s) => s)
                .asIterable()
                .map((f) => FlagWidget(name: f, value: flags.values[f]))
                .toList())
      ],
    );
  }
}