import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydispatch/data/MyUser.dart';
import 'package:mydispatch/pages/truck_detail.dart';

import '../data/MyUser.dart';
import '../data/ScheduleSearch.dart';
import 'driver_schedule.dart';

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
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.face_outlined),
                title: Text(name,style: const TextStyle(fontSize: 20),),
                subtitle: const Text('氏名'),
              ),
              ListTile(
                leading: const Icon(Icons.drive_file_rename_outline),
                title: Text(affiliation,style: const TextStyle(fontSize: 20),),
                subtitle: const Text('所属'),
              ),
              ListTile(
                leading: const Icon(Icons.mail_outline),
                title: Text(mail,style: const TextStyle(fontSize: 20),),
                subtitle: const Text('メールアドレス'),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(phone,style: const TextStyle(fontSize: 20),),
                subtitle: const Text('電話番号'),
              ),
              ListTile(
                leading: const Icon(Icons.drive_eta_outlined),
                title: Text(truck,style: const TextStyle(fontSize: 20),),
                subtitle: const Text('車番'),
              ),
              ElevatedButton(
                onPressed: () {
                  var search = ScheduleSearch();
                  search.setDriverConditions(driverId: id, driverName: name);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => DriverSchedule(search: search,))
                  );
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
        title: Text(
          widget.id == null ? 'ドライバー詳細' : 'ドライバー編集',
        ),
        actions: [
          if (widget.id != null)
            IconButton(
              icon: const Icon(Icons.delete_outline_outlined),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("${MyUser.getCompanyCode()}-users")
                    .doc(widget.id)
                    .delete();
                Navigator.pop(context);
              },
            )
        ],
      ),
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection("users").doc(widget.id).get(),
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
