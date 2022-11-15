import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メニュー'),
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
            ElevatedButton(
              onPressed: () async {
               await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/home');
                },
                child: Text('Logout')
            ),
          ],
        ),
      ),
    );
  }
}
