import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydispatch/pages/menu.dart';
import '/pages/menu.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/logo.jpg'),
              ),
              Container(
                child: Center(
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: true,
                        style: TextStyle(color: Colors.black),
                        obscureText: false,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          // icon: Icon(Icons.mail_lock_outlined),
                          hintText: 'メールアドレスを入力してください',
                          labelText: 'Email *',
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
                      Padding(padding: EdgeInsets.all(10.0))
                    ],
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: true,
                        style: TextStyle(color: Colors.black),
                        obscureText: true,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          // icon: Icon(Icons.security_outlined),
                          hintText: 'パスワードを入力してください',
                          labelText: 'Password *',
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
                      Padding(padding: EdgeInsets.all(10.0))
                    ],
                  ),
                ),
              ),
              ButtonBar(buttonPadding: EdgeInsets.all(30.0), children: [
                ElevatedButton(
                    onPressed: () =>onPressLoginButton(),
                    child: Text('log in')
                )
              ]),
              // TODO: ログイン後の画面に移動
              ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/new_employee'),
                  child: Text('社員向け新規登録')),
              TextButton(onPressed: null, child: Text('パスワードをお忘れの方はこちら')),
            ],
          ),
        ),
      ),
    );
  }

  /// ログインボタンが押された時の処理
  void onPressLoginButton() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      login(_email, _password);
    }
  }

  /// ログイン処理
  void login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
