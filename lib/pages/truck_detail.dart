import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mydispatch/data/MyUser.dart';
import 'package:mydispatch/data/ScheduleSearch.dart';
import 'package:mydispatch/pages/driver_schedule.dart';

class TruckDetail extends StatefulWidget {
  const TruckDetail({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<StatefulWidget> createState() => _TruckDetailState();
}

class _TruckDetailState extends State<TruckDetail> {
  Widget _truckDetailWidget({
    required String id,
    required String carNumber,
    required String carType,
    required String truckAffiliation,
    required String maxCapacity,
    required String carWeight,
    required String totalWeight,
    required String length,
    required String height,
    required String width,
  }) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.numbers),
              title: Text(
                carNumber,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: const Text('truck number'),
            ),
            ListTile(
              leading: const Icon(Icons.type_specimen),
              title: Text(
                carType,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: const Text('type'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text(
                maxCapacity + 'kg',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: const Text('最大積載量'),
            ),
            ListTile(
              leading: const Icon(Icons.monitor_weight),
              title: Text(
                carWeight + 'kg',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: const Text('車両重量'),
            ),
            ListTile(
              leading: const Icon(Icons.drive_eta_outlined),
              title: Text(
                totalWeight + 'kg',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: const Text('総重量'),
            ),
            ListTile(
              leading: const Icon(Icons.border_bottom_outlined),
              title: Text(
                length + 'cm',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: const Text('全長'),
            ),
            ListTile(
              leading: const Icon(Icons.height_outlined),
              title: Text(
                height + 'cm',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: const Text('高さ'),
            ),
            ListTile(
              leading: const Icon(Icons.width_full_outlined),
              title: Text(
                width + 'cm',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: const Text('車幅'),
            ),
            ListTile(
              leading: const Icon(Icons.schedule_outlined),
              title: Text(
                truckAffiliation,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: const Text('車検期限'),
            ),
            ElevatedButton(
              onPressed: () {
                var search = ScheduleSearch();
                search.setTruckConditions(
                    truckId: id, carNumber: carNumber, carType: carType);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => DriverSchedule(
                              search: search,
                            )));
              },
              child: const Text("登録スケジュール"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Truck Detail'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("${MyUser.getCompanyCode()}-trucks")
            .doc(widget.id)
            .get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot<Map<String, dynamic>> doc = snapshot.data!;
            if (doc.exists) {
              Map<String, dynamic> data = doc.data()!;
              return _truckDetailWidget(
                id: doc.id,
                carNumber: data['car_number'],
                carType: data['type'],
                maxCapacity: data['max_capacity'].toString(),
                carWeight: data['car_weight'].toString(),
                length: data['length'].toString(),
                height: data['height'].toString(),
                width: data['width'].toString(),
                truckAffiliation: data['truck_affiliation'],
                totalWeight: data['total_weight'].toString(),
              );
            } else {
              return const Text('トラック情報が見つかりませんでした');
            }
          }
          return const Text('loading...');
        },
      ),
    );
  }
}
