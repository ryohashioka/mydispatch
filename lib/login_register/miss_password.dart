import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('パスワード再発行画面'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "$_text",
            ),
            TextFormField(
              enabled: true,
              style: const TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: '登録したメールアドレスを入力してください。',
                labelText: 'email *',
              ),
              onChanged: _handleText,
            ),
            ButtonBar(buttonPadding: const EdgeInsets.all(60.0), children: [
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _text)
                      .then((value) => Navigator.pop(context, _text), onError: (e) {
                    const snackBar = SnackBar(
                      content: Text(
                        'メールを送信できませんでした',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: const Text(
                  'Send',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  alignment: Alignment.center,
                  minimumSize: const Size(242, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
