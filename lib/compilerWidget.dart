import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ql/controls.dart';

import 'constants.dart';

class CompilerWidget extends StatelessWidget {
  final controller = TextEditingController(text: startingProgram);
  @override
  Widget build(BuildContext context) {
    final progController = Provider.of<Controller>(context);
    progController.programUpdated(controller.text);
    final compiled = StreamBuilder<String>(
        stream: progController.compiled,
        initialData: "",
        builder: (c, d) => Container(
              child: Text(d.data,
                  style: TextStyle(fontFamily: "Courier", fontSize: 8)),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              width: 50,
              height: 400,
            ));
    var textForm = Container(
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: 100,
        onChanged: (t) {
          progController.programUpdated(t);
        },
        style: TextStyle(fontFamily: "Courier", fontSize: 12),
      ),
      width: 550,
      height: 400,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    );
    return Row(children: <Widget>[textForm, compiled]);
  }
}
