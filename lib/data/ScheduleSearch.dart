import 'package:cloud_firestore/cloud_firestore.dart';

import 'MyUser.dart';

class ScheduleSearch {
  String? truckId;
  String? carNumber;
  String? carType;

  //トラックの検索条件の設定//
  void setTruckConditions({
    required String truckId, //uid
    required String carNumber, //車番
    required String carType, //車種
  }) {
    this.truckId = truckId;
    this.carNumber = carNumber;
    this.carType = carType;
  }

  //2023/2/28宿題ドライバーの検索条件を設定する
  // void setDriverConditions() {
  // required String driverId, //uid
  // required String name, //名前
  // required String affiliation, //役職
  //
  // }

  Future<QuerySnapshot<Map<String, dynamic>>> exec() {
    late dynamic query;

    if (truckId != null) {
      query = FirebaseFirestore.instance
          .collection("${MyUser.getCompanyCode()}-schedules")
          .where('truck_id', isEqualTo: truckId);
    } else {
      query = FirebaseFirestore.instance
          .collection("${MyUser.getCompanyCode()}-schedules");
    }

    return query.get();
  }
}
