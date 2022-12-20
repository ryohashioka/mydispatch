import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewCompany extends StatefulWidget {
  @override
  _NewCompanyState createState() => _NewCompanyState();
}

class _NewCompanyState extends State<NewCompany> {
  final _formKey = GlobalKey<FormState>();
  String _companyname = "";
  // Bool _is_admin = ;
  String _manager = "";
  String _phonenumber = "";
  String _email = "";
  String _text = '';
  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Company'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.face),
                  hintText: '会社名を入力してください',
                  labelText: 'Company Name *',
                ),
                onSaved: (value) {
                  _companyname = value!;
                },
                onChanged: _handleText,
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.factory),
                  hintText: '担当者名を入力してください',
                  labelText: 'Manager *',
                ),
                onSaved: (value) {
                  _manager = value!;
                },
                onChanged: _handleText,
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: '電話番号を入力してください(ハイフンなし)',
                  labelText: 'Phone *',
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _phonenumber = value!;
                },
                onChanged: _handleText,
              ),
              TextFormField(
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
    }

    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      print(credential);

      if(credential.user != null) {
        print(credential.user!.uid);

        var db = FirebaseFirestore.instance;

        db

            .collection("users")
            .doc(credential.user!.uid)
            .set({
          "companyname": _companyname,
          "manager": _manager,
          "mail":_email,
          "phone": _phonenumber,
        })
            .onError((e, _) => print("Error writing ddocument: $e"));
      }

      Navigator.of(context).pop();
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


