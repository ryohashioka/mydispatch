import 'package:flutter/material.dart';
import 'create_employee.dart';
import 'create_outsider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body:
      Container(
        padding: EdgeInsets.all(80.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('ログイン画面'),
              Container(
                child: Center(
                  child: Column(
                  children: [TextField
                    (enabled: true,
                    style: TextStyle(color: Colors.black),
                    obscureText: false,
                    maxLines:1 ,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.work_outline_outlined),
                      hintText: 'メールアドレスを入力してください',
                      labelText: 'Email *',
                    ),)],
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Column(
                    children: [TextField
                      (enabled: true,
                      style: TextStyle(color: Colors.black),
                      obscureText: false,
                      maxLines:1 ,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.work_outline_outlined),
                        hintText: 'パスワードを入力してください',
                        labelText: 'Password *',
                      ),)],
                  ),
                ),
              ),
              TextButton(onPressed: () => Navigator.of(context).pushNamed('/new_employee'), child: Text('社員向け新規登録')),
              TextButton(onPressed: () => Navigator.of(context).pushNamed('/new_outsider'), child: Text('お客様向け新規登録')),
            ],
          ),
        ),
      ),
    );
  }
}