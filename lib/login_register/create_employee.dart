import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/MyUser.dart';

class NewEmployee extends StatefulWidget {

  final String companyCode;

  const NewEmployee({Key? key, required this.companyCode}) : super(key: key);

  @override
  _NewEmployeeState createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployee> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _name = "";
  String _affiriation = "";
  String _phonenumber = "";
  String _trucknumber = "";

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
              TextFormField(
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
              ),
              TextFormField(
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
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.fire_truck_outlined),
                  hintText: '担当トラックを入力してください',
                  labelText: 'Truck *',
                ),
                onSaved: (value) {
                  _trucknumber = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: '電話番号を入力してください(ハイフンなし)',
                  labelText: 'Phone *',
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _phonenumber = value!;
                },
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

      try {
        // TODO: ポジションの入力フォーム追加
        String _position = "一般";
        await MyUser.createUser(
          email: _email, password: _password, companyCode: widget.companyCode,
          name: _name, affiliation: _affiriation, position: _position,
          phoneNumber: _phonenumber,
        );

        // int count = 0;
        // Navigator.popUntil(context, (_) => count++ >= 2);

        // ホームヘ戻る
        Navigator.of(context).popUntil((route) => route.isFirst);
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
}

