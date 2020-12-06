import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePageScreen.dart';

import 'table.dart';
import 'customer.dart';

List<Table1> tables = [];
List<Customer> customers = [];
int extraSeats = 5;
void main() {
  tables = tableInit();
  customers.clear();

  runApp(MaterialApp(
    home: Login(),
  ));
}

List<Table1> tableInit() {
  List<Table1> tempTable = [];
  for (int i = 0; i < 5; i++) {
    Table1 temp = new Table1(i, 5);
    tempTable.add(temp);
  }
  return tempTable;
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String pword = '5555';

  final nameHolder = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Login Screen",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            )),
        body: new Container(
            padding: const EdgeInsets.all(40.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextField(
                    obscureText: true,
                    controller: nameHolder,
                    autocorrect: true,
                    decoration:
                        new InputDecoration(labelText: "Enter The Password"),
                    onSubmitted: (value) {
                      if (pword == value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageScreen()),
                        );
                      }
                      nameHolder.clear();
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                    ])
              ],
            )));
  }
}
