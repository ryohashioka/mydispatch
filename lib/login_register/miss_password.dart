import 'package:flutter/material.dart';

class MissPassword extends StatefulWidget {
  @override
  _MissPassword createState() => _MissPassword();
}

class _MissPassword extends State<MissPassword> {

  String _text = '';

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missing Password'),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "$_text",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500
              ),
            ),
            TextField(
              enabled: true,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: '登録したメールアドレスを入力してください。パスワードを送信します。',
                labelText: 'email *',
              ),
              onChanged: _handleText,
            ),
            ButtonBar(
                buttonPadding: EdgeInsets.all(30.0),
                children:[ElevatedButton(onPressed: null, child: Text('Send'))]),
          ],
        ),
      ),
    );
  }
}
