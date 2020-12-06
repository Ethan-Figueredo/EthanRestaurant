import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/main.dart';
import 'addCustomer.dart';
import 'subCustomer.dart';
import 'customer.dart';
import 'table.dart';

class Clerk extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Clerk> {
  @override
  Widget build(BuildContext context) {
    List input = [];
    final nameField = TextEditingController();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _showErrorName() async {
      await showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Error"),
                content: new Text("Input correct Name"),
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

    _showResultDialog(double number) async {
      await showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Waiting Time"),
                content: new Text("$number"),
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

    _showFullDialog(int number) async {
      await showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Waiting Time"),
                content: new Text(
                    "The Tables are Full. The Waiting time is: $number minutes"),
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

    _showNotFound() async {
      await showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Error"),
                content: new Text("Party can't be Seated at this time"),
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

    final middleSectionRow = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new IconButton(
          icon: Image.asset('images/addSign.png'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCustomer()),
          ),
        ),
        new IconButton(
          icon: Image.asset('images/subSign.png'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SubCustomer()),
          ),
        ),
      ],
    );
    final rightSection = new Expanded(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new RaisedButton(
            child: Text('Check Waiting Times'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black),
            ),
            color: Colors.blue.shade300,
            onPressed: () async {
              if (input.length == 1) {
                double found = await findWaitingTimes(input[0]);
                if (found == -1) {
                  _showErrorName();
                } else if (found < 0) {
                  int found1 = tables.length * 30;
                  _showFullDialog(found1);
                } else {
                  _showResultDialog(found);
                }
              } else {
                _showErrorName();
              }
              nameField.clear();
              input.clear();
            },
          ),
          new TextField(
            autocorrect: true,
            controller: nameField,
            decoration:
                new InputDecoration(labelText: "Enter The Customer's Name"),
            onSubmitted: (value) {
              input.add(value);
            },
          ),
        ],
      ),
    );
    final middleSection = new Expanded(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text(
            "WaitList",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          middleSectionRow,
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Clerk",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(20.0)),
                Expanded(
                  child: RaisedButton(
                    child: Text('Seat Next Party'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    color: Colors.blue.shade300,
                    onPressed: () async {
                      List<Table1> cleanTables = getCleanTable();
                      bool found = false;
                      for (int i = 0; i < customers.length; i++) {
                        int ifFound = await canBeSeated(customers[i]);
                        if (cleanTables.length != 0 && ifFound != 0) {
                          if (ifFound == 2) {
                            int seatsNeeded =
                                customers[i].partySize - cleanTables[0].seats;
                            extraSeats -= seatsNeeded;
                          }
                          cleanTables[0].clean = false;
                          customers.remove(customers[i]);
                          found = true;
                          break;
                        }
                      }
                      if (found == false) {
                        _showNotFound();
                      }
                    },
                  ),
                ),
                middleSection,
                rightSection,
                Padding(padding: const EdgeInsets.all(20.0)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<double> findWaitingTimes(String name) async {
  Customer found = await findCustomer(name);
  if (found != null) {
    int indexOfFound = customers.indexOf(found) + 1;
    int cleanTableLength = getCleanTable().length;
    if (cleanTableLength == 0) {
      double x = indexOfFound * 30.1;
      return x;
    }
  }
  return -1;
}

List<Table1> getCleanTable() {
  List<Table1> found = [];
  for (var i = 0; i < tables.length; i++) {
    if (tables[i].clean == true) {
      found.add(tables[i]);
    }
  }
  return found;
}

Future<int> canBeSeated(Customer name) async {
  for (int i = 0; i < tables.length; i++) {
    if (name.partySize <= tables[i].seats) {
      return 1;
    } else if (name.partySize <= tables[i].seats + extraSeats) {
      return 2;
    }
  }
  return 0;
}
