import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "ryo.hashioka@gmail.com";
  String _password = "samurai";

  String _text = "";

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
          child: Form(
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
                          obscureText: false,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            // icon: Icon(Icons.security_outlined),
                            hintText: 'パスワードを入力してください',
                            labelText: 'Password *',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0))
                      ],
                    ),
                  ),
                ),
                ButtonBar(buttonPadding: EdgeInsets.all(30.0), children: [
                  ElevatedButton(
                      onPressed: () =>
                          login(_email, _password),
                      child: Text('log in'))
                ]),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/new_employee'),
                    child: Text('社員向け新規登録')),
                // ElevatedButton(
                //     onPressed: () =>
                //         Navigator.of(context).pushNamed('/new_outsider'),
                //     child: Text('お客様向け新規登録')),
                TextButton(onPressed: null, child: Text('パスワードをお忘れの方はこちら')),
              ],
            ),
          ),
        ),
      );
  }

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
