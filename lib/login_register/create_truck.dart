import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // TODO: 車検は日付に変更
  String _inspectionDeadline = "";

  late DateTime _inspection;

  final TextEditingController _inspectionController = TextEditingController();

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
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.type_specimen_outlined),
                  hintText: '種類を入力してください',
                  labelText: 'type',
                ),
                onSaved: (value) {
                  _type = value!;
                },
              ),
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.factory_outlined),
                  hintText: '担当営業所を入力してください',
                  labelText: 'truck Affiliation *',
                ),
                onSaved: (value) {
                  _truckAffiliation = value!;
                },
              ),
              // TODO: 単位表記
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.shopping_bag_rounded),
                  hintText: '最大積載量を入力してください',
                  labelText: 'max capacity *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  // TODO: 数値のみを許可するように正規表現を記述
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
                  hintText: '車両重量を入力してください',
                  labelText: 'car weight *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  // TODO: 数値のみを許可するように正規表現を記述
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
                  hintText: '総重量を入力してください',
                  labelText: 'total weight *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  // TODO: 数値のみを許可するように正規表現を記述
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
                  hintText: '長さを入力してください',
                  labelText: 'length *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  // TODO: 数値のみを許可するように正規表現を記述
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
                  hintText: '高さを入力してください',
                  labelText: 'height *',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  // TODO: 数値のみを許可するように正規表現を記述
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
                  hintText: '車幅を入力してください',
                  labelText: 'width *',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  // TODO: 数値のみを許可するように正規表現を記述
                  _width = int.parse(value!);
                },
              ),
              TextFormField(
                enabled: true,
                style: const TextStyle(color: Colors.black),
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
                      lastDate: DateTime.now().add(const Duration(days: 360)));
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
