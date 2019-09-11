import 'package:flutter/material.dart';
import 'dart:html' as html;

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info),
      onPressed: () {
        // flutter defined function
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text("Writing Instruction Code"),
              content: Text(
                  "This simulator allows you to write instruction code and run it on a virtual computer written from nand gates!"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                  child: Text("Read More"),
                  onPressed: () {
                    html.window.open(
                        'https://docs.google.com/document/d/18yet44aINrhRZmlSvfkaI7lc6Qdz4Fjp28aqMGYgiHA/edit?usp=sharing',
                        'document');
                  },
                  color: Colors.purpleAccent,
                ),
                FlatButton(
                  child: Text("Dismiss"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
