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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const EmptyTruck();
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.search),
                    label: Text('空きトラック検索'),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const Reservation();
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.calendar_today),
                    label: Text('予約確認'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
