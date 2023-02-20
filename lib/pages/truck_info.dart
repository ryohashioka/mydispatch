import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mydispatch/data/MyUser.dart';
import 'package:mydispatch/pages/truck_detail.dart';


class TruckInfo extends StatefulWidget {
  const TruckInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TruckInfoState();
}
class _TruckInfoState extends State<TruckInfo> {

  Widget _truckItemWidget({
    required String id,
    required String carNumber,
    required String carType
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFF090A0A)))
      ),
      child: Column(
        children: [
          Text('Car No.' + carNumber),
          Text(carType),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => TruckDetail()
              ));
              print("トラックの詳細画面へ ($id)");
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
        title: const Text('Truck Info'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection(
            "${MyUser.getCompanyCode()}-trucks").get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            // TODO: トラック情報取得エラー処理
            return Text("トラック情報を取得できませんでした");
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data!.docs[index];
                  return _truckItemWidget(
                      id: data.id,
                      carNumber: data['carnumber'],
                      carType: data['type']
                  );
                }
            );
          }
          return const Text("loading...");
        },
      ),
    );
  }
}