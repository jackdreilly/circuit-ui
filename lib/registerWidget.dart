import 'package:flutter/material.dart';

class RegisterWidget extends StatelessWidget {
  final int value;
  final bool isActive;
  RegisterWidget({this.value, Key key, this.isActive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: isActive ? Colors.red : Colors.white),
        color: Colors.black,
      ),
      child: Text(
        hexValue(),
        style: TextStyle(color: Colors.lightGreen, fontFamily: "Courier"),
      ),
    );
  }

  String hexValue() {
    return value.toRadixString(16).padLeft(2, "0");
  }
}