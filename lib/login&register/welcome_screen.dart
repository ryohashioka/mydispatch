import 'package:flutter/material.dart';
import 'create_employee.dart';
import 'create_outsider.dart';
import 'create_truck.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WELLCOME TO MY DISPATCH',
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      routes:  {
        '/お客様はこちら':(context) => NewOutsider(),
        '/社員はこちら': (context) => NewEmployee(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Select you'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Text('Main'),
              TextButton(onPressed: () => Navigator.of(context).pushNamed("/subpage"), child: new Text('Subページへ'),)
            ],
          ),
        ),
      ),
    );
  }
}