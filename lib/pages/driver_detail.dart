import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydispatch/data/MyUser.dart';
import 'package:mydispatch/pages/truck_detail.dart';

import '../data/MyUser.dart';

class DriverDetail extends StatefulWidget {
  const DriverDetail({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<StatefulWidget> createState() => _DriverDetailState();
}

class _DriverDetailState extends State<DriverDetail> {
  Widget _driverDetailWidget({
    required String id,
    required String name,
    required String affiliation,
    required String mail,
    required String phone,
    required String truck,
  }) {
    return Container(
      child: Column(
        children: [
          Text('氏名:' + name),
          Text('メールアドレス：' + mail),
          Text('電話番号:' + phone),
          Text('役職:' + affiliation),
          Text('車番' + truck),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Detail'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("${MyUser.getCompanyCode()}-users")
            .doc(widget.id)
            .get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot<Map<String, dynamic>> doc = snapshot.data!;
            if (doc.exists) {
              Map<String, dynamic> data = doc.data()!;
              return _driverDetailWidget(
                id: doc.id,
                name: data['name'],
                mail: data['mail'],
                phone: data['phone'],
                affiliation: data['affiliation'],
                truck: data['truck'],
              );
            } else {
              return const Text('ドライバー情報が見つかりませんでした');
            }
          }
          return Text('loading...');
        },
      ),
    );
  }
}
