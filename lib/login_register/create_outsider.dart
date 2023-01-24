import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydispatch/data/MyUser.dart';

class NewOutsider extends StatefulWidget {

  final String companyCode;

  const NewOutsider({Key? key, required this.companyCode}) : super(key: key);

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
              Text(widget.companyCode),
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

      // TODO: 権限設定
      await MyUser.createUser(
        email: _email, password: _password, companyCode: widget.companyCode,
        name: _name, affiliation: _affiriation, position: _position,
        phoneNumber: _phonenumber,
      );
    }

    // ホームヘ戻る
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

