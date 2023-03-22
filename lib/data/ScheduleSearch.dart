import 'package:cloud_firestore/cloud_firestore.dart';

import 'MyUser.dart';

class ScheduleSearch {
  String? truckId;
  String? carNumber;
  String? carType;
  String? driverId;
  String? driverName;

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

  //ドライバーの検索条件の設定//
  void setDriverConditions({
    required String driverId, //uid
    required String driverName, //名前
  }) {
    this.driverId = driverId;
    this.driverName = driverName;
  }

  /// 検索処理を実行して結果を返却する。
  /// FIXME: データ登録件数が多くなると、取得に時間がかかるため、表示に不要なデータは取得しないような仕組みが必要
  /// 例えば、今日の日付から前後１ヶ月だけを取得して、残りは日付を変更したときに順次取得する、とか。
  Future<QuerySnapshot<Map<String, dynamic>>> exec() {
    dynamic query = FirebaseFirestore.instance
        .collection("${MyUser.getCompanyCode()}-schedules");

    if (truckId != null) {
      query = query.where('truck_id', isEqualTo: truckId);
    }

    if (driverId != null) {
      // TODO: driverID でスケジュールを検索する
      query = query.where('DriverName', isEqualTo: driverName);
    }
    return query.get();
  }
}
