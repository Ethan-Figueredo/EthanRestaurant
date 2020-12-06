import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/menu.dart';
import 'package:restaurant/table.dart';

class Waiter extends StatefulWidget {
  @override
  _State createState() => _State();
}

final List<Menu> totalMenu = initMenu();
List<Map> images = [
  {'name': 'addSign', 'iconPath': 'images/addSign.svg'},
  {'name': 'subSign', 'iconPath': 'images/subSign.svg'},
  {'name': 'menu', 'iconPath': 'images/menu1.svg'},
];

class _State extends State<Waiter> {
  final tableName = TextEditingController();
  final menuItem = TextEditingController();
  List inputs = [];
  _showTableName() async {
    await showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Error"),
              content: new Text("Input Correct Table Number"),
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

  _showMenuItem() async {
    await showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Error"),
              content: new Text("Input Correct Menu Name"),
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
    final rightSection = new Expanded(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new TextField(
              autocorrect: true,
              controller: tableName,
              decoration: new InputDecoration(
                  labelText: "Enter The Table Number before Submitting"),
              onSubmitted: (value) async {
                int value1 = int.parse(value);
                inputs.add(value1);
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
              ]),
          new TextField(
              autocorrect: true,
              controller: menuItem,
              decoration:
                  new InputDecoration(labelText: "Enter The Menu Item Number"),
              onSubmitted: (value) async {
                int value1 = int.parse(value);
                inputs.add(value1);
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
              ]),
          new RaisedButton(
            child: Text('Add Item'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black),
            ),
            color: Colors.blue.shade300,
            onPressed: () async {
              if (inputs.length == 2) {
                Table1 tableInput = await findTable(inputs[0]);
                Menu menuInput = await findMenu(inputs[1]);
                if (tableInput.name == -1) {
                  _showTableName();
                } else if (menuInput.name == -1) {
                  _showMenuItem();
                } else {
                  addItemToBill(tableInput, menuInput);
                }
              }
              menuItem.clear();
              tableName.clear();
              inputs.clear();
            },
          ),
        ],
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Waiter",
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
              Expanded(
                child: Image.asset(
                  'images/realmenu.PNG',
                  height: MediaQuery.of(context).size.height - 81,
                  width: (MediaQuery.of(context).size.width) * 0.5,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(padding: const EdgeInsets.all(20.0)),
              rightSection,
              Padding(padding: const EdgeInsets.all(20.0)),
            ],
          )
        ],
      )),
    );
  }
}

List<Menu> initMenu() {
  List<Menu> created = [];
  created.add(Menu(1, "Caesar Salad", 5));
  created.add(Menu(2, "Garden Salad", 5));
  created.add(Menu(3, "Spring Salad", 5));
  created.add(Menu(4, "Margherita", 9));
  created.add(Menu(5, "Meat Levers", 9));
  created.add(Menu(6, "Pesto Shrimp", 9));
  created.add(Menu(7, "Baked Ziti", 4));
  created.add(Menu(8, "Baked Macaroni", 4));
  created.add(Menu(9, "Penne with Tomato", 4));
  created.add(Menu(10, "Banana Muffin", 7));
  created.add(Menu(11, "Carrot Muffin", 7));
  created.add(Menu(12, "Brownie", 7));
  return created;
}

Future<Table1> findTable(int number) async {
  for (int i = 0; i < tables.length; i++) {
    if (tables[i].name == number) {
      return tables[i];
    }
  }
  return new Table1(-1, 0);
}

Future<Menu> findMenu(int number) async {
  for (int i = 0; i < totalMenu.length; i++) {
    if (totalMenu[i].name == number) {
      return totalMenu[i];
    }
  }
  return new Menu(-1, "null", 0);
}

Future<void> addItemToBill(Table1 table, Menu item) async {
  int indexTable = tables.indexOf(table);
  int indexItem = totalMenu.indexOf(item);

  tables[indexTable].foodBill.add(totalMenu[indexItem]);
}
