import 'package:flutter/material.dart';
import 'create_employee.dart';
import 'create_outsider.dart';
import 'create_truck.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new NewOutsider(),
        '/subpage': (BuildContext context) => new NewEmployee()
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Navigator'),
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
class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Navigator'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Text('Sub'),
              TextButton(onPressed: () => Navigator.of(context).pop(), child: new Text('戻る'),)
            ],
          ),
        ),
      ),
    );
  }
}