import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class NewTruck extends StatefulWidget {
  @override
  _NewTruckState createState() => _NewTruckState();
}


class _NewTruckState extends State<NewTruck> {
  final _formKey = GlobalKey<FormState>();
  String _carNumber = "";
  String _type = "";
  String _maxCapacity = "";
  String _carWeight = "";
  String _totalWeight = "";
  String _length = "";
  String _height = "";
  String _width = "";
  String _inspectionDeadline = "";

  late DateTime _inspection;

  final TextEditingController _inspectionController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Truck'),
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
                  icon: Icon(Icons.fire_truck_outlined),
                  hintText: '車番を入力してください',
                  labelText: 'Car number *',
                ),
                keyboardType: TextInputType.number,
                //パスワード
                onSaved: (value) {
                  _carNumber = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.type_specimen_outlined),
                  hintText: '種類を入力してください',
                  labelText: 'type *',
                ),
                onSaved: (value) {
                  _type = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.shopping_bag_rounded),
                  hintText: '最大積載量を入力してください',
                  labelText: 'max capacity *',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _maxCapacity = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.fire_truck_outlined),
                  hintText: '車両重量を入力してください',
                  labelText: 'car weight *',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _carWeight = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.monitor_weight_outlined),
                  hintText: '総重量を入力してください',
                  labelText: 'total weight *',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _totalWeight = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.line_weight),
                  hintText: '長さを入力してください',
                  labelText: 'length *',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _length = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.height),
                  hintText: '高さを入力してください',
                  labelText: 'height *',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _height = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.width_wide_outlined),
                  hintText: '車幅を入力してください',
                  labelText: 'width *',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _width = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.schedule_outlined),
                  hintText: '車検期限を入力してください',
                  labelText: 'inspection deadline *',
                ),
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _inspection,
                      firstDate: DateTime(2016),
                      lastDate: DateTime.now().add(
                          Duration(days: 360))
                  );
                },
                onSaved: (value) {
                  _inspectionDeadline = value!;
                },
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  var state = _formKey.currentState;
                  if (state != null && state.validate()) {
                    state.save();

                    var db = FirebaseFirestore.instance;
                    db.collection("trackinfo").add({
                      "carnumber": _carNumber,
                      "type": _type,
                      "max capasity": _maxCapacity,
                      "car weight": _carWeight,
                      "total weight": _totalWeight,
                      "length": _length,
                      "height": _height,
                      "width": _width,
                      "inspection deadline": _inspectionDeadline,
                    }).then((res) {
                      Navigator.pop(context);
                    });
                  }
                },
                icon: Icon(Icons.add),
                label: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
//   void create(BuildContext context) async {
//     if (_formKey.currentState != null && _formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//     }
//
//     try {
//       final credential =
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _email,
//         password: _password,
//       );
//
//       print(credential);
//
//       if (credential.user != null) {
//         print(credential.user!.uid);
//
//         var db = FirebaseFirestore.instance;
//
//         db
//
//             .collection("users")
//             .doc()
//             .set({
//           "carnumber": _carNumber,
//           "type": _type,
//           "max capasity": _maxCapacity,
//           "car weight": _carWeight,
//           "total weight": _totalWeight,
//           "length": _length,
//           "height": _height,
//           "width": _width,
//           "inspection deadline": _inspectionDeadline,
//         })
//             .onError((e, _) => print("Error writing ddocument: $e"));
//       }
//
//       Navigator.of(context).pop();
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }