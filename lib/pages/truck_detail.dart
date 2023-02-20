import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydispatch/data/MyUser.dart';
import 'package:mydispatch/pages/truck_detail.dart';

import '../data/MyUser.dart';


class TruckDetail extends StatefulWidget {
  const TruckDetail({Key? key}) : super(key: key);

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
      child: Column(
        children: [
          Text('Car No.' + carNumber),
          Text(carType),
          Text('最大積載量:' + maxCapacity + 'kg'),
          Text('車両重量:' + carWeight + 'kg'),
          Text('車両総重量' + totalWeight + 'kg'),
          Text('長さ:' + length + 'cm'),
          Text('高さ:' + height + 'cm'),
          Text('幅:' + width + 'cm'),
          Text('車検期限' + truckAffiliation),
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
        future: FirebaseFirestore.instance.collection(
            "${MyUser.getCompanyCode()}-trucks").get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data!.docs[index];
                  return _truckDetailWidget(
                    id: data.id,
                    carNumber: data['carnumber'],
                    carType: data['type'],
                    maxCapacity: data['maxcapacity'],
                    carWeight: data['carweight'],
                    length: data['length'],
                    height: data['height'],
                    width: data['width'],
                    truckAffiliation: data['truckaffiliation'],
                    totalWeight: data['totalweight'],
                  );
                }
            );
          }
        },
      ),
    );
  }
}