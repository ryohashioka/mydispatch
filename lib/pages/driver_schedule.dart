import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'dart:math' as math;

class DriverSchedule extends StatelessWidget {
  const DriverSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("スケジュール"),
      ),
      body: MonthView(
        onEventTap: (events, date) {
          print(events);
          print(date);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/new_schedule');
          }
      ),
    );
  }
}


