import 'package:flutter/material.dart';


class DriverInfo extends StatefulWidget {
  const DriverInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DriverInfoState();
}
class _DriverInfoState extends State<DriverInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Info'),
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