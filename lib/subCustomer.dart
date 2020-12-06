import 'package:flutter/material.dart';
import 'package:restaurant/customer.dart';
import 'package:restaurant/main.dart';

class SubCustomer extends StatefulWidget {
  @override
  _SubCustomerState createState() => _SubCustomerState();
}

class _SubCustomerState extends State<SubCustomer> {
  @override
  Widget build(BuildContext context) {
    final nameField = TextEditingController();
    List input = [];

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

    _showNotFoundDialog() async {
      await showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Error"),
                content: new Text("Not Found"),
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

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
        padding: const EdgeInsets.all(40.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              controller: nameField,
              autocorrect: true,
              decoration: new InputDecoration(labelText: "Customer's Name"),
              onSubmitted: (value) {
                input.add(value);
              },
            ),
            new RaisedButton(
              child: Text('Remove Customer'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black),
              ),
              color: Colors.blue.shade300,
              onPressed: () async {
                if ((input.length) == 1) {
                  Customer found = await findCustomer(input[0]);
                  if (found != null) {
                    customers.remove(found);
                  } else {
                    await _showNotFoundDialog();
                  }
                } else {
                  await _showErrorName();
                }
                input.clear();
                nameField.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<Customer> findCustomer(String personName) async {
  for (var i = 0; i < customers.length; i++) {
    if (customers[i].name == personName) {
      // Found the person, stop the loop
      return customers[i];
    }
  }
  return null;
}
