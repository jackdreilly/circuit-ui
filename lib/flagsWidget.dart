import 'package:flutter/material.dart';
import 'package:queries/collections.dart';

import 'flagWidget.dart';
import 'flags.dart';

class FlagsWidget extends StatelessWidget {
  final Flags flags;

  final String title;

  const FlagsWidget({Key key, this.title, this.flags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Row(
            children: Collection(flags.values.keys.toList())
                .orderBy((s) => s)
                .asIterable()
                .map((f) => Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: FlagWidget(name: f, value: flags.values[f]),
                    ))
                .toList())
      ],
    );
  }
}
