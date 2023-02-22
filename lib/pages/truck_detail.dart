import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mydispatch/data/MyUser.dart';

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
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.numbers),
            title: Text('No.' + carNumber,style: const TextStyle(fontSize: 20),),
          ),
          ListTile(
            leading: const Icon(Icons.type_specimen),
            title: Text(carType,style: const TextStyle(fontSize: 20),),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: Text('最大積載量:' + maxCapacity + 'kg',style: const TextStyle(fontSize: 20),),
          ),
          ListTile(
            leading: const Icon(Icons.monitor_weight),
            title: Text('車両重量:' + carWeight + 'kg',style: const TextStyle(fontSize: 20),),
          ),
          ListTile(
            leading: const Icon(Icons.drive_eta_outlined),
            title: Text('総重量:' + totalWeight + 'kg',style: const TextStyle(fontSize: 20),),
          ),
          ListTile(
            leading: const Icon(Icons.border_bottom_outlined),
            title: Text('全長:' + length + 'cm',style: const TextStyle(fontSize: 20),),
          ),
          ListTile(
            leading: const Icon(Icons.height_outlined),
            title: Text('高さ:' + height + 'cm',style: const TextStyle(fontSize: 20),),
          ),
          ListTile(
            leading: const Icon(Icons.width_full_outlined),
            title: Text('車幅:' + width + 'cm',style: const TextStyle(fontSize: 20),),
          ),
          ListTile(
            leading: const Icon(Icons.schedule_outlined),
            title: Text('車検期限:' + truckAffiliation,style: const TextStyle(fontSize: 20),),
          ),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text("登録スケジュール"),
          )
        ],

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
          return Text('loading...');
        },
      ),
    );
  }
}
