import 'package:flutter/material.dart';


class TruckInfo extends StatefulWidget {
  const TruckInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TruckInfoState();
}
class _TruckInfoState extends State<TruckInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Truck Info'),
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