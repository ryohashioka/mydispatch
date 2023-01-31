import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import "package:intl/intl.dart";
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydispatch/pages/create_schedule.dart';


class DriverSchedule extends StatelessWidget {
  const DriverSchedule({Key? key}) : super(key: key);

  void resetEvents(BuildContext context) {
    final controller = CalendarControllerProvider.of(context).controller;
    for(var event in controller.events) {
      controller.remove(event);
    }
  }

  void getSchedules(BuildContext context) {
    resetEvents(context);
    //ここに処理を書く
    FirebaseFirestore.instance.collection('000-schedules').get().then((res) {
      final events = res.docs.map((doc) {
        final data = doc.data();
        final startDt = data['start_datetime'].toDate();
        final endDt = data['end_datetime'].toDate();
        return CalendarEventData(
          date: startDt,
          startTime: startDt,
          endTime: endDt,
          title: "${data['SiteName']}/ ${data['CompanyName']}様/ ${data['DriverName']}",
          event: doc.id,
        );
      }).toList();
      CalendarControllerProvider.of(context).controller.addAll(events);
    });
  }

  @override
  Widget build(BuildContext context) {
    var rand = math.Random();
    var dayFormat = DateFormat('yyyy/MM/dd(E)');

    getSchedules(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
      ),
      body: DayView(
        dateStringBuilder: (DateTime date, {DateTime? secondaryDate}) {
          return dayFormat.format(date);
        },
        onEventTap: (events, date) async {
          String? docID = events[0].event as String?;
          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewSchedule(id: docID))
          );
          getSchedules(context);
          // print(events);
          // print(date);
          //   String? docID = events[0].event as String?;
          //   FirebaseFirestore.instance.collection('000-schedules').doc(docID).delete();
          //   getSchedules(context);
            },
          ),
          floatingActionButton: FloatingActionButton(
          onPressed: ()
           async {
            await Navigator.of(context).pushNamed('/new_schedule');
            getSchedules(context);
          },
          child: Icon(Icons.calendar_today_outlined),
      ),
    );
  }
}


