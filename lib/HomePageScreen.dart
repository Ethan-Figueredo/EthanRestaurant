import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Clerk.dart';
import 'Busboy.dart';
import 'Waiter.dart';

class HomePageScreen extends StatefulWidget {
  //add textfield below check waiting times: Done
  //hard code inputs: done
  //init tables: done
  //init empty customers via list: done
  //add customers name: done
  //remove customers name: done
  //checkwaiting times checks if value is not null then looks for customer in list and prints dialog to screen: done
  //text next party: done
  //busboy:
  //waiter
  //timeout to login

  @override
  _State createState() => _State();
}

class _State extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Users",
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text('Clerk'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                      color: Colors.blue.shade300,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Clerk()),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(40.0)),
                  Expanded(
                    child: RaisedButton(
                      child: Text('Busboy'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                      color: Colors.blue.shade300,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Busboy()),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(40.0)),
                  Expanded(
                    child: RaisedButton(
                      child: Text('Waiter'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                      color: Colors.blue.shade300,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Waiter()),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
