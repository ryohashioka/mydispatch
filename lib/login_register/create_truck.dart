import 'package:flutter/material.dart';

class NewTruck extends StatefulWidget {
  @override
  _NewTruck createState() => _NewTruck();
}

class _NewTruck extends State<NewTruck> {

  String _text = '';

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Truck'),
      ),
      body:SingleChildScrollView(
        // padding: const EdgeInsets.all(70.0),
        child: Column(
          children: <Widget>[
            Text(
              "$_text",
              style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500
              ),
            ),
            new TextField(
              enabled: true,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              decoration: const InputDecoration(
                icon: Icon(Icons.fire_truck_outlined),
                hintText: '車番を入力してください',
                labelText: 'Car number *',
              ),
              //パスワード
              onChanged: _handleText,
            ),
            new TextField(
              enabled: true,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              decoration: const InputDecoration(
                icon: Icon(Icons.type_specimen_outlined),
                hintText: '種類を入力してください',
                labelText: 'type *',
              ),
              onChanged: _handleText,
            ),
            new TextField(
              enabled: true,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              decoration: const InputDecoration(
                icon: Icon(Icons.shopping_bag_rounded),
                hintText: '最大積載量を入力してください',
                labelText: 'max capacity *',
              ),
              onChanged: _handleText,
            ),
            new TextField(
              enabled: true,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              decoration: const InputDecoration(
                icon: Icon(Icons.fire_truck_outlined),
                hintText: '車両重量を入力してください',
                labelText: 'car weight *',
              ),
              onChanged: _handleText,
            ),
            new TextField(
              enabled: true,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              decoration: const InputDecoration(
                icon: Icon(Icons.monitor_weight_outlined),
                hintText: '総重量を入力してください',
                labelText: 'total weight *',
              ),
              onChanged: _handleText,
            ),
            new TextField(
              enabled: true,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              decoration: const InputDecoration(
                icon: Icon(Icons.line_weight),
                hintText: '長さを入力してください',
                labelText: 'length *',
              ),
              onChanged: _handleText,
            ),
            new TextField(
              enabled: true,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              decoration: const InputDecoration(
                icon: Icon(Icons.height),
                hintText: '高さを入力してください',
                labelText: 'height *',
              ),
              onChanged: _handleText,
            ),
            new TextField(
              enabled: true,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              decoration: const InputDecoration(
                icon: Icon(Icons.width_wide_outlined),
                hintText: '車幅を入力してください',
                labelText: 'width *',
              ),
              onChanged: _handleText,
            ),
            new TextField(
              enabled: true,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines:1 ,
              decoration: const InputDecoration(
                icon: Icon(Icons.schedule_outlined),
                hintText: '車検期限を入力してください',
                labelText: 'inspection deadline *',
              ),
              onChanged: _handleText,
            ),
          ],
        ),
      ),
    );
  }
}