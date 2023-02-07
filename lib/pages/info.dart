import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mydispatch/components/user_profile.dart';
import 'package:mydispatch/data/MyUser.dart';
import 'package:mydispatch/pages/driver_info.dart';
import 'package:mydispatch/pages/truck_info.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

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
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child:  const ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  trailing: Icon(Icons.arrow_back),
                ),
              ),
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              child:  const ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                trailing: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
      child: Form(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: const Icon(
                Icons.local_shipping,size: 200),
      ),
          Container(
            child: ElevatedButton(
              child: Text('Truck Info'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
              ),
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TruckInfo()),
            ),
          ),
          ),
          Container(
            child: const Icon(
                Icons.face_outlined,size: 200),
          ),
          Container(
            child: ElevatedButton(
              child: Text('Driver Info'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
              ),
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DriverInfo()),
            ),
          ),
          ),
        ],
      ),
    ),
    ),
    );
  }
}
