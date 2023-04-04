import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/MyUser.dart';

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
  String _position = "";
  String _affiliation = "";
  String _phonenumber = "";
  String _trucknumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Drivers'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.face),
                  labelText: '氏名 *',
                ),
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.factory),
                  labelText: '所属 *',
                ),
                onSaved: (value) {
                  _affiliation = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.factory),
                  labelText: '役職 *',
                ),
                onSaved: (value) {
                  _position = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.fire_truck_outlined),
                  labelText: '担当トラック *',
                ),
                onSaved: (value) {
                  _trucknumber = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: '電話番号 *',
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _phonenumber = value!.replaceAll(RegExp(r'-'), '');
                },
                validator: (value) {
                  if (value!.contains('-')) {
                    return "ハイフンは不要です！";
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'メールアドレス *',
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
                style: const TextStyle(color: Colors.black),
                obscureText: true,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  labelText: 'パスワード *',
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
                  onPressed: () => create(context), child: const Text('Register')),
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
        // TODO: 権限設定
        await MyUser.createUser(
          email: _email,
          password: _password,
          companyCode: widget.companyCode,
          name: _name,
          affiliation: _affiliation,
          position: _position,
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
