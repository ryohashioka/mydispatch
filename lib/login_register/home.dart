import 'package:flutter/material.dart';
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
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
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
