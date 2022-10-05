import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_register/home.dart';
import 'login_register/create_employee.dart';
import 'login_register/create_outsider.dart';
// import 'login_register/create_employee.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes:  <String, WidgetBuilder>{
        '/home':(BuildContext context) =>  MainPage(),
        '/new_employee': (BuildContext context) => NewEmployee(),
        '/new_outsider': (BuildContext context) => NewOutsider(),
      },
    );
  }
}