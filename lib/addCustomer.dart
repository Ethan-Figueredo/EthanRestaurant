import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/customer.dart';

import 'package:restaurant/main.dart';

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    final nameField = TextEditingController();
    final numberField = TextEditingController();
    _showMaterialDialog() {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Error"),
                content: new Text("Input Both fields before Submitting"),
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

    List inputs = [];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Add Customer's Name",
            style: TextStyle(
              color: Colors.white,
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
              controller: nameField,
              autocorrect: true,
              decoration: new InputDecoration(labelText: "Customer's Name"),
              onSubmitted: (value) async {
                inputs.add(value);
              },
            ),
            new TextField(
                controller: numberField,
                autocorrect: true,
                decoration:
                    new InputDecoration(labelText: "Customer's Party Size"),
                onSubmitted: (value) async {
                  int numValue = int.parse(value);
                  inputs.add(numValue);
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                ]),
            new RaisedButton(
                child: Text('Add Customer'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black),
                ),
                color: Colors.blue.shade300,
                onPressed: () {
                  if ((inputs.length) == 2) {
                    customers.add(new Customer(inputs[0], inputs[1]));
                  } else {
                    _showMaterialDialog();
                  }
                  inputs.clear();
                  numberField.clear();
                  nameField.clear();
                } //check if array is filled if filled then accept else reject
                ),
          ],
        ),
      ),
    );
  }
}
