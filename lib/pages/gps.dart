import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class GpsPage extends StatelessWidget {
  const GpsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: 300.0,
          height: 300.0,
          child: Text("test"),
          padding: const EdgeInsets.all(50.0),
        ),
      ),
    );
  }
}
