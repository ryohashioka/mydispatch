import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import "package:intl/intl.dart";
import 'dart:math' as math;

class DriverSchedule extends StatelessWidget {
  const DriverSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rand = math.Random();
    var dayFormat = DateFormat('yyyy/MM/dd(E)');

    return Scaffold(
      appBar: AppBar(
        title: Text("Shedule"),
      ),
      body: DayView(
        dateStringBuilder: (DateTime date, {DateTime? secondaryDate}) {
          return dayFormat.format(date);
        },
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


