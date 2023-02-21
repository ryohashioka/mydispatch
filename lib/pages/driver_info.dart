import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/MyUser.dart';
import 'driver_detail.dart';

class DriverInfo extends StatefulWidget {
  const DriverInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  Widget _driverItemWidget(
      {required String id, required String name, required String affiliation}) {
    return Container(
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFF090A0A)))),
      child: Column(
        children: [
          Text(name),
          Text(affiliation),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => DriverDetail(id: id,)));
              print("ドライバーの詳細画面へ ($id)");
            },
            child: const Text("詳細を見る"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Info'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('company_code', isEqualTo: MyUser.getCompanyCode())
            .where('role', isEqualTo: 1)
            .get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data!.docs[index];
                  return _driverItemWidget(
                      id: data.id,
                      name: data['name'],
                      affiliation: data['affiliation']);
                });
            return Text("ここにデータを表示します");
          }
          return const Text('loading...');
        },
      ),
    );
  }
}
