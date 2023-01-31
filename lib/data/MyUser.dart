import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class MyUser {
  static Map<String, dynamic>? currentUser;
  // TODO: 20230131_ログイン時にユーザ情報と共に企業情報も取得する。

  static bool isAdmin() {
    return MyUser.currentUser != null && MyUser.currentUser!['role'] == 0;
  }

  // TODO: createUser！
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
}
