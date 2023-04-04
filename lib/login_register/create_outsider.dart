import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mydispatch/data/MyUser.dart';

//TODO 20230117 create_employee108〜バリデーターを参考に記入してみる
/// 管理者ユーザの作成画面
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
  String _name = "";
  String _affiliation = "";
  String _position = "";
  String _phonenumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Users',
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // padding: const EdgeInsets.all(70.0),
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
                  icon: Icon(Icons.drive_file_rename_outline),
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
              // TODO: ドライバー or 管理者の選択（ラジオボタン？）
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
        await MyUser.createUser(
          email: _email,
          password: _password,
          companyCode: widget.companyCode,
          name: _name,
          affiliation: _affiliation,
          position: _position,
          phoneNumber: _phonenumber,
          role: 0,
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
