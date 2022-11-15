import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewEmployee extends StatefulWidget {
  @override
  _NewEmployeeState createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployee> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  String _text = '';
  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Users'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.face),
                  hintText: '名前を入力してください',
                  labelText: 'Name *',
                ),
                //パスワード
                onChanged: _handleText,
              ),
              TextField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.factory),
                  hintText: '所属を入力してください',
                  labelText: 'Affiliation *',
                ),
                onChanged: _handleText,
              ),
              TextField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.fire_truck_outlined),
                  hintText: '担当トラックを入力してください',
                  labelText: 'Truck *',
                ),
                onChanged: _handleText,
              ),
              TextField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: '電話番号を入力してください',
                  labelText: 'Phone *',
                ),
                keyboardType: TextInputType.phone,
                onChanged: _handleText,
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'メールアドレスを入力してください',
                  labelText: 'email *',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "メールアドレスを入力してください";
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
                onChanged: _handleText,
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: true,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  hintText: 'パスワードを入力してください',
                  labelText: 'password *',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "パスワードを入力してください";
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
                onChanged: _handleText,
              ),
              ElevatedButton(
                  onPressed: () => create(context), child: Text('Register')),
            ],
          ),
        ),
      ),
    );
  }

  void create(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      print(credential);

      if(credential.user != null) {
        print(credential.user!.uid);

        var db = FirebaseFirestore.instance;

        db

            .collection("users")
            .doc(credential.user!.uid)
            .set({
              "name": "西川　拓",
              "affiliation": "所属",
              "truck": 10,
              "phone": "000-0000-0000",
        })
        .onError((e, _) => print("Error writing ddocument: $e"));
      }

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
