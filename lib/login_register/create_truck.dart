import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../data/MyUser.dart';

class NewTruck extends StatefulWidget {
  @override
  _NewTruckState createState() => _NewTruckState();
}

class _NewTruckState extends State<NewTruck> {
  final _formKey = GlobalKey<FormState>();
  String _carNumber = "";
  String _type = "";
  String _truckAffiliation = "";
  int _maxCapacity = 0; // l
  int _carWeight = 0; // g
  int _totalWeight = 0; // g
  int _length = 0; // mm
  int _height = 0; // mm
  int _width = 0; // mm

  late DateTime _inspection;

  final TextEditingController _inspectionController = TextEditingController();
  DateTime _inspectionDeadline = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Truck'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // padding: const EdgeInsets.all(70.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.fire_truck_outlined),
                  labelText: '車番 *',
                ),
                keyboardType: TextInputType.number,
                //パスワード
                onSaved: (value) {
                  _carNumber = value!;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return '入力してください';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.type_specimen_outlined),
                  labelText: '車種',
                ),
                onSaved: (value) {
                  _type = value!;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return '入力してください';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.factory_outlined),
                  labelText: '担当部店 *',
                ),
                onSaved: (value) {
                  _truckAffiliation = value!;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return '入力してください';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.shopping_bag_rounded),
                  labelText: '最大積載量(kg) *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '入力してください';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                    return '数値を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  _maxCapacity = int.parse(value!);
                },
              ),
              // TODO: 単位表記
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.fire_truck_outlined),
                  labelText: '車両重量(kg) *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '入力してください';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                    return '数値を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  _carWeight = int.parse(value!);
                },
              ),
              // TODO: 単位表記
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.monitor_weight_outlined),
                  labelText: '総重量(kg) *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '入力してください';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                    return '数値を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  _totalWeight = int.parse(value!);
                },
              ),
              // TODO: 単位表記
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.line_weight),
                  labelText: '長さ(cm) *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '入力してください';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                    return '数値を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  _length = int.parse(value!);
                },
              ),
              // TODO: 単位表記
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.height),
                  labelText: '高さ(cm) *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '入力してください';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                    return '数値を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  _height = int.parse(value!);
                },
              ),
              // TODO: 単位表記
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.width_wide_outlined),
                  labelText: '車幅(cm) *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '入力してください';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                    return '数値を入力してください';
                  }
                  return null;
                },
                onSaved: (value) {
                  _width = int.parse(value!);
                },
              ),
              TextFormField(
                controller: _inspectionController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range),
                  labelText: '車検期限 *',
                ),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _inspectionDeadline,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 36500)),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _inspectionDeadline = selectedDate;
                      _inspectionController.text = DateFormat.yMd().format(_inspectionDeadline);
                    });
                  }
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return '入力してください';
                  }
                  return null;
                },
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  var state = _formKey.currentState;
                  if (state != null && state.validate()) {
                    state.save();

                    var db = FirebaseFirestore.instance;
                    db.collection("${MyUser.getCompanyCode()}-trucks").add({
                      "car_number": _carNumber,
                      "type": _type,
                      "truck_affiliation": _truckAffiliation,
                      "max_capacity": _maxCapacity,
                      "car_weight": _carWeight,
                      "total_weight": _totalWeight,
                      "length": _length,
                      "height": _height,
                      "width": _width,
                      "inspection_deadline": _inspectionDeadline,
                    }).then((res) {
                      Navigator.pop(context);
                    });
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}