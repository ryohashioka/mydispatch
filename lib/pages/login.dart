import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellcome!'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Image.asset('assets/images/logo.jpg'),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    TextFormField(
                      enabled: true,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          // icon: Icon(Icons.mail_lock_outlined),
                          labelText: 'Email *',
                          prefixIcon: Icon(Icons.mail),
                          border: OutlineInputBorder()),
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
                    const Padding(padding: EdgeInsets.all(10.0))
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    TextFormField(
                      enabled: true,
                      style: const TextStyle(color: Colors.black),
                      obscureText: true,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          // icon: Icon(Icons.security_outlined),
                          labelText: 'Password *',
                          prefixIcon: Icon(Icons.password_outlined),
                          border: OutlineInputBorder()),
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
                    const Padding(padding: EdgeInsets.all(10.0))
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => onPressLoginButton(),
                      child: const Text(
                        'log in',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo,
                        alignment: Alignment.center,
                        minimumSize: const Size(242, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        var result = await Navigator.of(context)
                            .pushNamed('/miss_password');
                        if (result != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('メールを送信しました'),
                            ),
                          );
                        }
                      },
                      child: const Text('パスワードをお忘れの方はこちら'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        alignment: Alignment.center,
                        minimumSize: const Size(100, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          color: Colors.indigo,
          child: const Center(
            child: Text(
              'MyDispatch App',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///ログインボタンが押された時の処理
  void onPressLoginButton() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      login(_email, _password);
    }
  }

  void login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
         var snackBar = SnackBar(
          content: Text(
            'ログインできません！メールアドレスに誤りがあります！',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        var snackBar = SnackBar(
          content: Text(
            'ログインできません！パスワードに誤りがあります！',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
