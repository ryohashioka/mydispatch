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
        child:SingleChildScrollView(
         child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/logo.jpg'),
              ),
              Container(
                child: Center(
                  child: Column(
                  children:
                  [TextField
                    (enabled: true,
                    style: TextStyle(color: Colors.black),
                    obscureText: false,
                    maxLines:1 ,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail_lock_outlined),
                      hintText: 'メールアドレスを入力してください',
                      labelText: 'Email *',
                    ),),
                    Padding(padding: EdgeInsets.all(10.0))
                  ],
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Column(
                    children:
                    [TextField
                      (enabled: true,
                      style: TextStyle(color: Colors.black),
                      obscureText: false,
                      maxLines:1 ,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.security_outlined),
                        hintText: 'パスワードを入力してください',
                        labelText: 'Password *',
                      ),),
                      Padding(padding: EdgeInsets.all(10.0))
                    ],
                  ),
                ),
              ),
              ButtonBar(
                buttonPadding: EdgeInsets.all(30.0),
                  children:[ElevatedButton(onPressed: null, child: Text('log in'))]),
              ElevatedButton(onPressed: () => Navigator.of(context).pushNamed('/new_employee'), child: Text('社員向け新規登録')),
              ElevatedButton(onPressed: () => Navigator.of(context).pushNamed('/new_outsider'), child: Text('お客様向け新規登録')),
              TextButton(onPressed: null, child: Text('パスワードをお忘れの方はこちら')),
            ],
          ),
        ),
      ),
      ),
    );
  }
}