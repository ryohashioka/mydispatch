import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewSchedule extends StatefulWidget {
  @override
  _NewScheduleState createState() => _NewScheduleState();
}

class _NewScheduleState extends State<NewSchedule> {
  final _formKey = GlobalKey<FormState>();
  String _carnumber = "";
  String _drivername = "";
  String _companyname = "";
  String _address ="";
  String _sitename ="";
  String _phonenumber ="";
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
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.local_shipping_outlined),
                  hintText: '車番を入力してください',
                  labelText: 'Car Number *',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _carnumber = value!;
                },
                onChanged: _handleText,
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'ドライバーを選択してください',
                  labelText: 'Driver Name *',
                ),
                onSaved: (value) {
                  _drivername = value!;
                },
                onChanged: _handleText,
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.factory_outlined),
                  hintText: '取引先を入力してください',
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
                  icon: Icon(Icons.pin_drop_outlined),
                  hintText: '住所を入力してください',
                  labelText: 'Address *',
                ),
                onSaved: (value) {
                  _address = value!;
                },
                onChanged: _handleText,
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.construction_outlined),
                  hintText: '現場名を入力してください',
                  labelText: 'Site Name',
                ),
                onSaved: (value) {
                  _sitename = value!;
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
                  hintText: '先方電話番号を入力してください（ハイフンなし）',
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _phonenumber = value!;
                },
                onChanged: _handleText,
              ),
              TextFormField(
                  readOnly: true,
                  // enabled: true,
                  style: TextStyle(color: Colors.black),
                  obscureText: false,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.date_range),
                    hintText: '開始日付を入力してください',
                    labelText: 'Start Date *',
                  ),
                  keyboardType: TextInputType.datetime,
                  onSaved: (value) {
                    _startdate = value!;
                  },
                  onChanged: _handleText,
                   onTap: () async {
                     final DateTime? picked = await showDatePicker(
                         context: context,
                         initialDate: DateTime.now(),
                         firstDate: new DateTime(2016),
                         lastDate: new DateTime.now().add(
                             new Duration(days: 360))
                     );
                     if (picked != null) {
                       onSaved:(value) {
                         _startdate = value!;
                       };
                     }
                   }
                ),
              TextFormField(
                readOnly: true,
                // enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range),
                  hintText: '終了日付を入力してください',
                  labelText: 'End Date *',
                ),
                keyboardType: TextInputType.datetime,
                onSaved: (value) {
                  _enddate = value!;
                },
                onChanged: _handleText,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: new DateTime(2016),
                        lastDate: new DateTime.now().add(
                            new Duration(days: 360))
                    );
                    if (picked != null) {
                      onSaved:(value) {
                        _startdate = value!;
                      };
                    }
                  }
              ),
              FloatingActionButton.extended(onPressed: null,
                  icon:Icon(Icons.add),
                  label:const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

