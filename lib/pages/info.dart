import 'package:flutter/material.dart';
import 'package:mydispatch/pages/driver_info.dart';
import 'package:mydispatch/pages/truck_info.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('検索メニュー'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: const Icon(Icons.local_shipping, size: 200),
              ),
              Container(
                child: ElevatedButton(
                  child: Text('トラック情報'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const TruckInfo()),
                  ),
                ),
              ),
              Container(
                child: const Icon(Icons.face_outlined, size: 200),
              ),
              Container(
                child: ElevatedButton(
                  child: const Text('ドライバー情報'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const DriverInfo()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
