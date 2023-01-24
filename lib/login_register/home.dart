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
        MyUser.currentUser = null;
      } else {
        print('User is signed in!');
        // TODO 新規登録時エラーになるかも要検証
        var db = FirebaseFirestore.instance;
        final docRef = db.collection("users").doc(user.uid);

        try {
          DocumentSnapshot doc = await docRef.get();
          MyUser.currentUser = doc.data() as Map<String, dynamic>;
        } catch (e) {
          // TODO エラー処理
          print("認証情報が取得できなかったよ");
          MyUser.currentUser = null;
          FirebaseAuth.instance.signOut();
        }
      }
      // TODO if文の中に書いたほうがいい？エラー時にデータがおかしくなる??
      setState(() {
        this.user = user;
      });
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
