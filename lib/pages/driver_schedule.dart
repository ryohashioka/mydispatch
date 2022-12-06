import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'dart:math' as math;

class DriverSchedule extends StatelessWidget {
  const DriverSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var rand = math.Random();

    DateTime _now = DateTime.now();

    final event = CalendarEventData(
      date: _now,
      event: "ID1",
      title: "XX会社引き取り",
      description: "ワンマン1",
      startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
      endTime: DateTime(_now.year, _now.month, _now.day, 22),
    );

    final event2 = CalendarEventData(
      date: _now,
      event: "ID2",
      title: "Project meeting",
      description: "Today is project meeting.",
      startTime: DateTime(_now.year, _now.month, _now.day, 10),
      endTime: DateTime(_now.year, _now.month, _now.day, 12),
    );

    CalendarControllerProvider.of(context).controller.add(event);
    CalendarControllerProvider.of(context).controller.add(event2);
    return Scaffold(
      appBar: AppBar(
        title: Text("スケジュール"),
      ),
      body: DayView(
        onEventTap: (events, date){
          print(events);
          print(date);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var hour = rand.nextInt(23);

          CalendarControllerProvider.of(context).controller.add(CalendarEventData(
            date: _now,
            event: "ID2",
            title: "Project meeting",
            description: "Today is project meeting.",
            startTime: DateTime(_now.year, _now.month, _now.day, hour),
            endTime: DateTime(_now.year, _now.month, _now.day, hour +1),
          ));
          print("カレンダー登録画面へ！");
        },
        child: Icon(Icons.calendar_today_outlined),
      ),
      );
  }
}


