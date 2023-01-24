import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydispatch/login_register/create_company.dart';
import 'package:mydispatch/login_register/create_truck.dart';
import 'package:mydispatch/pages/create_schedule.dart';
import 'login_register/home.dart';
import 'login_register/create_employee.dart';
import 'login_register/create_outsider.dart';
import 'login_register/miss_password.dart';
import 'pages/menu.dart';
// import 'login_register/create_employee.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calendar_view/calendar_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'root',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // firebaseとflutterでアプリを作るときの定型文↑
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        home: MainPage(),
        routes:  <String, WidgetBuilder>{
          '/home':(BuildContext context) =>  MainPage(),
          '/new_employee': (BuildContext context) => NewEmployee(),
          // '/new_outsider': (BuildContext context) => NewOutsider(),
          '/miss_password': (BuildContext context) => MissPassword(),
          '/new_schedule': (BuildContext context) => NewSchedule(),
          '/new_company' : (BuildContext context) => NewCompany(),
          '/new_truck' : (BuildContext context) => NewTruck(),
          '/menu' : (BuildContext context) => MenuPage(),


       },
      ),
    );
  }
}