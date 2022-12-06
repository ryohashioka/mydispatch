import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewSchedule extends StatefulWidget {
  @override
  _NewScheduleState createState() => _NewScheduleState();
}

class _NewScheduleState extends State<NewSchedule> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _startdate = "";
  String _enddate = "";

  String _text = "";

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New Schedule',
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // padding: const EdgeInsets.all(70.0),
          child: Column(
            children: <Widget>[
              Text(
                "$_text",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500),
              ),
              new TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.face),
                  hintText: '名前を入力してください',
                  labelText: 'Name *',
                ),
                onSaved: (value) {
                  _name = value!;
                },
                onChanged: _handleText,
              ),
              new TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range),
                  hintText: '開始日付を入力してください',
                  labelText: 'Start Date *',
                ),
                onSaved: (value) {
                  _startdate = value!;
                },
                onChanged: _handleText,
              ),
              new TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range),
                  hintText: '終了日付を入力してください',
                  labelText: 'End Date *',
                ),
                onSaved: (value) {
                  _enddate = value!;
                },
                onChanged: _handleText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}