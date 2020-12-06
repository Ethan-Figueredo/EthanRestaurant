import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/main.dart';

class Busboy extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Busboy> {
  final cleanTable = TextEditingController();

  List input = [];
  _showErrorDialog() async {
    await showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Error"),
              content: new Text("Input Correct Table"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return new Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Busboy",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: new Container(
          padding: const EdgeInsets.all(40),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text('Clean Table'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                      color: Colors.blue.shade300,
                      onPressed: () {
                        if (input.length == 1 &&
                            input[0] <= tables.length &&
                            input[0] > 0) {
                          for (int i = 0; i < tables.length; i++) {
                            if (input[0] == tables[i].name) {
                              tables[i].clean = true;
                              tables[i].foodBill.clear();
                              if (tables[i].seats > 5) {
                                extraSeats = tables[i].seats - 5 + extraSeats;
                              }
                              tables[i].seats = 5;
                              break;
                            }
                          }
                        } else {
                          _showErrorDialog();
                        }
                        input.clear();

                        cleanTable.clear();
                      },
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(40.0)),
                  Expanded(
                      child: new TextField(
                    controller: cleanTable,
                    autocorrect: true,
                    decoration: new InputDecoration(
                        labelText: "Enter The Table Number before Submitting"),
                    onSubmitted: (value) {
                      int value1 = int.parse(value);
                      input.add(value1);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                    ],
                  ))
                ],
              )
            ],
          )),
    );
  }
}
