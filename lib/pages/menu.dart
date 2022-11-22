import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mydispatch/components/user_profile.dart';

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
              child: Container(
                width: 600,height: 240,
                child: Image.asset(
                    'assets/images/menu1_search.jpg',
                    fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 600,height: 240,
                child: Image.asset(
                  'assets/images/menu2_schedule.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 600,height: 240,
                child: Image.asset(
                  'assets/images/menu3_gps.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 600,height: 240,
                child: Image.asset(
                  'assets/images/menu4_info.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
