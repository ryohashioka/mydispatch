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
  /// ドライバーの検索条件を設定する。
  void setDriverConditions() {}

  /// 検索処理を実行して結果を返却する。
  /// FIXME: データ登録件数が多くなると、取得に時間がかかるため、表示に不要なデータは取得しないような仕組みが必要
  /// 例えば、今日の日付から前後１ヶ月だけを取得して、残りは日付を変更したときに順次取得する、とか。

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
