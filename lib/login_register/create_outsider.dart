import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewOutsider extends StatefulWidget {
  @override
  _NewOutsiderState createState() => _NewOutsiderState();
}

class _NewOutsiderState extends State<NewOutsider> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _company = "";
  String _name = "";
  String _affiriation = "";
  String _position = "";
  String _phonenumber = "";

  String _text = "";
  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New Users',
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // padding: const EdgeInsets.all(70.0),
          child: Column(
            children: <Widget>[
              new TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.work_outline_outlined),
                  hintText: '会社名を入力してください',
                  labelText: 'CompanyName *',
                ),
                onSaved: (value) {
                  _company = value!;
                },
                onChanged: _handleText,
              ),
              new TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.face),
                  hintText: '名前を入力してください',
                  labelText: 'Name *',
                ),
                onSaved: (value) {
                  _name = value!;
                },
                onChanged: _handleText,
              ),
              new TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.factory),
                  hintText: '所属を入力してください',
                  labelText: 'Affiliation *',
                ),
                onSaved: (value) {
                  _affiriation = value!;
                },
                onChanged: _handleText,
              ),
              new TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.drive_file_rename_outline),
                  hintText: '役職を入力してください',
                  labelText: 'Position *',
                ),
                onSaved: (value) {
                  _position = value!;
                },
                onChanged: _handleText,
              ),
              new TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: '電話番号を入力してください（ハイフンなし）',
                  labelText: 'Phone *',
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _phonenumber = value!;
                },
                onChanged: _handleText,
              ),
              new TextFormField(
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
              new TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
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
          "company": _company,
          "name": _name,
          "affiliation": _affiriation,
          "position": _position,
          "phone": _phonenumber,
          "email": _email,
          "password": _password,
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

