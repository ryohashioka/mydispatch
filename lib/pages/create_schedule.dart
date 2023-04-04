import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mydispatch/data/MyUser.dart';

class NewSchedule extends StatefulWidget {
  final String? id;

  const NewSchedule({Key? key, this.id}) : super(key: key);

  @override
  _NewScheduleState createState() => _NewScheduleState();
}

class _NewScheduleState extends State<NewSchedule> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _startdate;
  late TimeOfDay _starttime;
  late DateTime _enddate;
  late TimeOfDay _endtime;

  final TextEditingController _carNumberController = TextEditingController();
  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _siteNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  DateFormat _outputFormat = DateFormat('yyyy/MM/dd');

  List<QueryDocumentSnapshot<Map<String, dynamic>>> trucks = [];
  String selectedTruckId = '';

  //startDateとStartTimeの値をセットする文
  void _setStartDt(DateTime dt) {
    _startdate = dt;
    _startDateController.text = _outputFormat.format(dt);
    _starttime = TimeOfDay(hour: dt.hour, minute: dt.minute);
    _startTimeController.text = "${dt.hour}:${dt.minute}";
  }

  void _setEndDt(DateTime dt) {
    _enddate = dt;
    _endDateController.text = _outputFormat.format(dt);
    _endtime = TimeOfDay(hour: dt.hour, minute: dt.minute);
    _endTimeController.text = "${dt.hour}:${dt.minute}";
  }

  void _getTruck() {
    FirebaseFirestore.instance
        .collection("${MyUser.getCompanyCode()}-trucks")
        .get()
        .then((QuerySnapshot<Map<String,dynamic>> val) {
          setState(() {
            trucks = val.docs;
          });
          if(val.docs.isNotEmpty) {
            setState(() {
              selectedTruckId = val.docs[0].id;
            });
          }
        })
    ;
  }

  @override
  void initState() {
    _getTruck();
    _setStartDt(DateTime.now());
    _setEndDt(DateTime.now());

    if (widget.id != null) {
      print(widget.id);
      FirebaseFirestore.instance
          .collection("${MyUser.getCompanyCode()}-schedules")
          .doc(widget.id)
          .get()
          .then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final startDt = data['start_datetime'].toDate();
        _setStartDt(startDt);
        final endDt = data['end_datetime'].toDate();
        _setEndDt(endDt);
        _carNumberController.text = data['CarNumber'];
        _driverNameController.text = data['DriverName'];
        _companyNameController.text = data['CompanyName'];
        _addressController.text = data['Address'];
        _siteNameController.text = data['SiteName'];
        _phoneNumberController.text = data['PhoneNumber'];
        _descriptionController.text = data['Description'];
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id == null ? '新規スケジュール作成' : '登録スケジュール編集',
        ),
        actions: [
          if (widget.id != null)
            IconButton(
              icon: const Icon(Icons.delete_outline_outlined),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("${MyUser.getCompanyCode()}-schedules")
                    .doc(widget.id)
                    .delete();
                Navigator.pop(context);
              },
            )
        ],
      ),
      //*TODO: ドライバーの名前を選択したいが混乱、取り急ぎ上のコード貼り付けただけ*//
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // padding: const EdgeInsets.all(70.0),
          child: Column(
            children: <Widget>[
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: '車番 *'),
                  items: trucks
                      .map<DropdownMenuItem<String>>((truck) =>
                          DropdownMenuItem<String>(
                              value: truck.id,
                              child: Text(truck.data()['car_number'])))
                      .toList(),
                  value: selectedTruckId,
                  onChanged: (val) {
                    print(val);
                  },
                  onSaved: (val) {
                    selectedTruckId = val.toString();
                  }),
              DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: '氏名　*'),
                  items: trucks
                      .map<DropdownMenuItem<String>>((truck) =>
                      DropdownMenuItem<String>(
                          value: truck.id,
                          child: Text(truck.data()['car_number'])))
                      .toList(),
                  value: selectedTruckId,
                  onChanged: (val) {
                    print(val);
                  },
                  onSaved: (val) {
                    selectedTruckId = val.toString();
                  }),
              TextFormField(
                controller: _companyNameController,
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.factory_outlined),
                  labelText: '取引先 *',
                ),
              ),
              TextFormField(
                controller: _addressController,
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.pin_drop_outlined),
                  labelText: '住所 *',
                ),
              ),
              TextFormField(
                controller: _siteNameController,
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.construction_outlined),
                  labelText: '現場名',
                ),
              ),
              TextFormField(
                controller: _phoneNumberController,
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: '先方電話番号',
                ),
                keyboardType: TextInputType.phone,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                        controller: _startDateController,
                        readOnly: true,
                        // enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: false,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.date_range),
                          labelText: '開始日 *',
                        ),
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _startdate,
                              firstDate: DateTime(2016),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 360)));
                          if (picked != null) {
                            _startDateController.text =
                                _outputFormat.format(picked);
                            _startdate = picked;
                          }
                        }),
                  ),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                        controller: _startTimeController,
                        readOnly: true,
                        // enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: false,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          labelText: '開始時間 *',
                        ),
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: _starttime,
                          );
                          if (picked != null) {
                            _startTimeController.text =
                                "${picked.hour}:${picked.minute}";
                            _starttime = picked;
                          }
                        }),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _endDateController,
                      readOnly: true,
                      // enabled: true,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: '終了日 *',
                      ),
                      keyboardType: TextInputType.datetime,
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _enddate,
                            firstDate: DateTime(2016),
                            lastDate: DateTime.now().add(const Duration(days: 360)));
                        if (picked != null) {
                          _endDateController.text =
                              _outputFormat.format(picked);
                          _enddate = picked;
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "必須項目です！";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                        controller: _endTimeController,
                        readOnly: true,
                        // enabled: true,
                        style: const TextStyle(color: Colors.black),
                        obscureText: false,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          labelText: '終了時間 *',
                        ),
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: _endtime,
                          );
                          if (picked != null) {
                            _endTimeController.text =
                                "${picked.hour}:${picked.minute}";
                            _endtime = picked;
                          }
                        }),
                  )
                ],
              ),
              TextFormField(
                controller: _descriptionController,
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.text_fields_outlined),
                  labelText: '備考',
                ),
                keyboardType: TextInputType.text,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  var state = _formKey.currentState;
                  if (state != null && state.validate()) {
                    state.save();

                    var db = FirebaseFirestore.instance;
                    db.collection("${MyUser.getCompanyCode()}-schedules").add({
                      'truck_id': selectedTruckId,
                      'CarNumber': _carNumberController.text,
                      'DriverName': _driverNameController.text,
                      'CompanyName': _companyNameController.text,
                      'Address': _addressController.text,
                      'SiteName': _siteNameController.text,
                      'PhoneNumber': _phoneNumberController.text,
                      'start_datetime': DateTime(
                        _startdate.year,
                        _startdate.month,
                        _startdate.day,
                        _starttime.hour,
                        _starttime.minute,
                      ),
                      'end_datetime': DateTime(
                        _enddate.year,
                        _enddate.month,
                        _enddate.day,
                        _endtime.hour,
                        _endtime.minute,
                      ),
                      'Description': _descriptionController.text,
                      'created_user_id': FirebaseAuth.instance.currentUser!.uid,
                    }).then((res) {
                      Navigator.pop(context);
                    });
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('登録'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO
// if(widget.id != null) {
//                       // 更新
//                       db.collection("").doc(widget.id).set({}).then((res) {
//                         Navigator.pop(context);
//                       });
//                     } else {
//                       // 新規
//                     }
