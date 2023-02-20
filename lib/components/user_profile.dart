import 'package:flutter/material.dart';


import '../data/MyUser.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
          children: [
            Text(MyUser.currentUser!['name']),
            Text(MyUser.currentUser!['phone']),
            Text(MyUser.currentUser!['affiliation']),
            Text("${MyUser.currentUser!['truck']}"),
          ]
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );
  }
}
