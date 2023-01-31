import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mydispatch/data/MyUser.dart';
import 'create_employee.dart';
import 'create_outsider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mydispatch/pages/login.dart';
import 'package:mydispatch/pages/menu.dart';



class MainPage extends StatefulWidget {
 const MainPage({Key? key}) : super(key: key);

 @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  User? user;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
        MyUser.destroy();

        setState(() {
          this.user = user;
        });
      } else {
        print('User is signed in!');

        try {
          await MyUser.setupCurrentUser(userId: user.uid);
          await MyUser.setupCurrentCompany(companyCode: MyUser.currentUser!['company_code']);

          // ユーザ情報や法人情報が取得できない場合は異常終了（サインアウト）
          if (MyUser.currentUser == null || MyUser.currentCompany == null) {
            throw Exception("Failed to get user | company.");
          }

          setState(() {
            this.user = user;
          });
        } catch (e) {
          // TODO エラー処理
          print("認証情報が取得できなかったよ");

          MyUser.destroy();
          await FirebaseAuth.instance.signOut();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return const MenuPage();
    }
    return LoginPage();
  //  TODO ↑修正前はreturn const だったがこれでいいのか・・・（constを消したらエラー消えた）
  }
}
