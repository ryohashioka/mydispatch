import 'package:flutter/material.dart';
import 'package:mydispatch/login_register/create_company.dart';
import 'package:mydispatch/login_register/create_truck.dart';
import 'package:mydispatch/pages/create_schedule.dart';
import 'login_register/home.dart';
import 'login_register/miss_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
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
          '/miss_password': (BuildContext context) => MissPassword(),
          '/new_schedule': (BuildContext context) => NewSchedule(),
          '/new_company' : (BuildContext context) => NewCompany(),
          '/new_truck' : (BuildContext context) => NewTruck(),
       },
      ),
    );
  }
}