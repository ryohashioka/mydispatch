import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mydispatch/components/user_profile.dart';
import 'package:mydispatch/data/MyUser.dart';
import '/pages/driver_schedule.dart';
import 'package:mydispatch/login_register/create_truck.dart';
import '/pages/search.dart';
import '/pages/gps.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メニュー'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserProfile(),
            if(MyUser.isAdmin())
              GestureDetector(
                onTap: () async {
                  Navigator.pushNamed(context, '/new_company');
                },
                child:  const ListTile(
                  leading: Icon(Icons.factory),
                  title: Text("法人登録"),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, '/new_truck');
              },
              child:  const ListTile(
                leading: Icon(Icons.drive_eta_outlined),
                title: Text("トラック登録"),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              child:  const ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => const SearchPage()
                  ));
                },
                child: Container(
                  width: 600,height: 240,
                  child: Image.asset(
                    'assets/images/menu1_search.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => const DriverSchedule()
                  ));
                },
                child: Container(
                  width: 600,height: 240,
                  child: Image.asset(
                    'assets/images/menu2_schedule.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => const GpsPage()
                  ));
                },
                child: Container(
                  width: 600,height: 240,
                  child: Image.asset(
                    'assets/images/menu3_gps.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => NewTruck()
                  ));
                },
                child: Container(
                  width: 600,height: 240,
                  child: Image.asset(
                    'assets/images/menu4_info.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
