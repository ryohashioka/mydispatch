import 'package:flutter/material.dart';
import 'package:mydispatch/pages/empty_truck.dart';
import 'package:mydispatch/pages/reservation.dart';

class DispatchMenu extends StatelessWidget {
  const DispatchMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('配車登録・閲覧メニュー'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) {
                      return  const EmptyTruck();
                    }
                ));
              },
              child: Text('空きトラック検索')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const Reservation();
                }));
              },
              child: Text('予約確認')),
        ],
      ),
    );
  }
}
