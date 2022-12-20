import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
  DateTime? _startdate;
  TimeOfDay? _starttime;
  DateTime? _enddate;
  TimeOfDay? _endtime;

  String _text = "";

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

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
              Row(
                children: [
                  Flexible(child:
                  TextFormField(
                      controller: _startDateController,
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
                          DateFormat outputFormat = DateFormat('yyyy/MM/dd');
                          _startDateController.text = outputFormat.format(picked);
                          _startdate =picked;
                         }
                        }
                  ),
                  ),
                  Container(
                    width: 100,
                    padding: EdgeInsets.only(left: 10),
                    child:
                    TextFormField(
                        controller: _startTimeController,
                        readOnly: true,
                        // enabled: true,
                        style: TextStyle(color: Colors.black),
                        obscureText: false,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: '開始時間を入力してください',
                          labelText: 'Start Hour *',
                        ),
                        keyboardType: TextInputType.datetime,
                        onChanged: _handleText,
                        onTap: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) {
                            _startTimeController.text = "${picked.hour}:${picked.minute}";
                            _starttime=picked;
                          }
                        }
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(child:
                  TextFormField(
                      controller: _endDateController,
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
                      onChanged: _handleText,
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2016),
                            lastDate: DateTime.now().add(
                                Duration(days: 360))
                        );
                        if (picked != null) {
                          DateFormat outputFormat = DateFormat('yyyy/MM/dd');
                          _endDateController.text = outputFormat.format(picked);
                          _enddate =picked;
                        }
                      },
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "必須項目です！";
                        }
                        return null;
                        },
                    ),
                  ),
                  Container(
                    width: 100,
                    padding: EdgeInsets.only(left: 10),
                    child:
                    TextFormField(
                        controller: _endTimeController,
                        readOnly: true,
                        // enabled: true,
                        style: TextStyle(color: Colors.black),
                        obscureText: false,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: '終了時間を入力してください',
                          labelText: 'End Hour *',
                        ),
                        keyboardType: TextInputType.datetime,
                        onChanged: _handleText,
                        onTap: () async {
                          final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) {
                            _endTimeController.text = "${picked.hour}:${picked.minute}";
                            _endtime =picked;
                          }
                        }
                    ),
                  )
                ],
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  var state = _formKey.currentState;
                  if(state != null && state.validate()){
                    state.save();

                    var db = FirebaseFirestore.instance;
                    // TODO スケジュールに企業コードを適用
                    db.collection("000-schedules").add({
                      'CarNumber' : _carnumber,
                      'DriverName' : _drivername,
                      'CompanyName' : _companyname,
                      'Address' : _address,
                      'SiteName' : _sitename,
                      'PhoneNumber' : _phonenumber,
                      'start_datetime' : DateTime(
                        _startdate!.year,
                        _startdate!.month,
                        _startdate!.day,
                        _starttime!.hour,
                        _starttime!.minute,
                      ),
                      'end_datetime' : DateTime(
                        _enddate!.year,
                        _enddate!.month,
                        _enddate!.day,
                        _endtime!.hour,
                        _endtime!.minute,
                      ),
                      'created_user_id' :FirebaseAuth.instance.currentUser!.uid,
                    }).then((res) {
                      Navigator.pop(context);
                    });
                  }
                },
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

