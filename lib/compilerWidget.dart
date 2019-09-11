import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';

import 'constants.dart';
import 'infoWidget.dart';
import 'ramData.dart';

class CompilerWidget extends StatefulWidget {
  final ValueChanged<String> onRun;

  const CompilerWidget({Key key, this.onRun}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CompilerState();
  }
}

class CompilerState extends State<CompilerWidget> {
  String compiledText = "";
  bool isLoading = false;
  var controller = TextEditingController(text: startingProgram);
  @override
  Widget build(BuildContext context) {
    var result = Container(
      child: Text(compiledText,
          style: TextStyle(fontFamily: "Courier", fontSize: 8)),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      width: 50,
      height: 400,
    );
    var textForm = Container(
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: 100,
        style: TextStyle(fontFamily: "Courier", fontSize: 12),
      ),
      width: 550,
      height: 400,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    );
    final buttons = Row(children: [
      Padding(padding: EdgeInsets.all(10), child: InfoWidget()),
      Padding(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            child: Text("Compile"),
            onPressed: _fetchData,
          )),
      Padding(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            child: Text("Run"),
            onPressed: () async {
              await _fetchData();
              widget.onRun(controller.text);
            },
          ))
    ]);
    return Column(
      children: <Widget>[
        Row(children: <Widget>[textForm, result]),
        buttons,
      ],
    );
  }

  _fetchData() async {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Compiling program')));
    setState(() {
      isLoading = true;
    });
    final response = await BrowserClient().post(parseAddress,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"program": controller.text}));
    Scaffold.of(context).hideCurrentSnackBar();
    if (response.statusCode == 200) {
      final result = RamData.fromJson({"data": json.decode(response.body)});
      compiledText = result.data.map((f) => f.join()).join("\n");
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
    setState(() {
      isLoading = false;
    });
  }
}