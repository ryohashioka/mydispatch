import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydispatch/login_register/create_outsider.dart';

class NewCompany extends StatefulWidget {
  @override
  _NewCompanyState createState() => _NewCompanyState();
}

class _NewCompanyState extends State<NewCompany> {
  final _formKey = GlobalKey<FormState>();
  String _companyname = "";
  String _manager = "";
  String _phonenumber = "";
  String _email = "";

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
      var db = FirebaseFirestore.instance;

      // TODO: 20230131_管理会社区分
      var ds = await db.collection("company").add({
        "companyname": _companyname,
        "manager": _manager,
        "mail": _email,
        "phone": _phonenumber,
      });

      String companyCode = ds.id;

      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewOutsider(companyCode: companyCode,)));
      // TODO: 以下のコードは不要
      // Navigator.pop(context);

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



