import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class MyUser {
  static Map<String, dynamic>? currentUser;
  static Map<String, dynamic>? currentCompany;

  static void destroy() {
    MyUser.currentUser = null;
    MyUser.currentCompany = null;
  }

  // TODO: 権限処理など認証ユーザの情報が必須な時、currentUser が null だとログアウトしてもいいかも。

  // NOTE: 権限メモ
  //   - 管理法人 x 管理ユーザ : 法人登録可能
  //   - 管理法人 x ドライバー : 通常機能のみ
  //   - 一般法人 x 管理ユーザ : 法人内ユーザ登録が可能
  //   - 一般法人 x ドライバー : 通常機能のみ
  /// 認証ユーザが管理法人で管理ユーザの場合 true
  static bool isAdmin() {
    return MyUser.currentUser != null && MyUser.currentUser!['role'] == 0
        && MyUser.currentCompany != null && MyUser.currentCompany!['is_admin'];
  }

  /// 認証ユーザが一般法人で管理ユーザの場合 true
  static bool isManager() {
    return MyUser.currentUser != null && MyUser.currentUser!['role'] == 0
        && MyUser.currentCompany != null && !MyUser.currentCompany!['is_admin'];
  }

  /// 認証ユーザがドライバー権限の場合、true
  static bool isDriver() {
    return MyUser.currentUser != null && MyUser.currentUser!['role'] == 1;
  }

  /// カンパニーコードを取得する
  static String getCompanyCode() {
    if (MyUser.currentUser == null) {
      FirebaseAuth.instance.signOut();
      throw Exception("Not authenticated");
    } else {
      if (MyUser.currentUser!['company_code'] == null) {
        throw Exception("Not found company code!");
      }
      return MyUser.currentUser!['company_code'];
    }
  }

  static Future<void> createUser({
    required String email, required String password,
    required String companyCode, required String name,
    required String affiliation, required String position,
    required String phoneNumber, String truckNumber = "", int role = 1,
  }) async {
    // Firebase Auth
    // Firestore User Collection
    final app = await Firebase.initializeApp(
      name: 'my-user-fb-instance',
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // TODO: 削除
    print(app);

    final credential = await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(
      email: email, password: password
    );

    // TODO: 削除！（認証情報をログに出力されるとセキュリティリスク高）
    print(credential);

    if(credential.user != null) {
      var db = FirebaseFirestore.instance;

      await db.collection("users").doc(credential.user!.uid).set({
        "company_code": companyCode,
        "name": name,
        "affiliation": affiliation,
        "position": position,
        "mail": email,
        "truck": truckNumber,
        "phone": phoneNumber,
        "role": role
      });
    }
  }

  /// currentUser の情報を FireStore から取得して設定する
  static Future<void> setupCurrentUser({
    required String userId
  }) async {
    var res = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    MyUser.currentUser = res.data();
  }

  /// currentCompany の情報を FireStore から取得して設定する
  static Future<void> setupCurrentCompany({
    required String companyCode
  }) async {
    var res = await FirebaseFirestore.instance.collection('company').doc(companyCode).get();
    MyUser.currentCompany = res.data();
  }

}
