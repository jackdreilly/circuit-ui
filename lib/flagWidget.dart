import 'package:flutter/material.dart';

class FlagWidget extends StatelessWidget {
  final String name;
  final bool value;

  const FlagWidget({Key key, this.name, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(name,
        style: TextStyle(color: value ? Colors.green : Colors.grey));
  }
}