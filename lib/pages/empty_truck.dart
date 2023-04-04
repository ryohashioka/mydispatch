import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mydispatch/data/MyUser.dart';
import 'package:mydispatch/data/ScheduleSearch.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class _EmptyTruckEvent {
  final String id;

  const _EmptyTruckEvent(this.id);

  @override
  String toString() => id;
}

class EmptyTruck extends StatefulWidget {
  const EmptyTruck({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmptyTruckState();
}

class _EmptyTruckState extends State<EmptyTruck> {
  late final ValueNotifier<List<_EmptyTruckEvent>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  var kEvents = LinkedHashMap<DateTime, List<_EmptyTruckEvent>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _trucks = [];

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    _getSchedules();
    _getTrucks();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  /// Firestore からスケジュールデータを取得する。
  void _getSchedules() async {
    var querySnapshot = await ScheduleSearch().exec();
    Map<DateTime, List<_EmptyTruckEvent>> eventMap = {};
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      if (!data.containsKey('truck_id')) {
        // truck_id が入っていない時は無視する。
        continue;
      }
      // 日跨ぎのデータを考慮し、start と end の差分を取得して連続追加
      DateTime startDatetime = data['start_datetime'].toDate();
      DateTime endDatetime = data['end_datetime'].toDate();
      int dayOfDiff =
          endDatetime.difference(startDatetime).inDays; // 日付の差分（end - start）
      for (int i = 0; i <= dayOfDiff.abs(); i++) {
        // end の方が古ければ引き算
        DateTime dt = dayOfDiff > 0
            ? startDatetime.add(Duration(days: i))
            : startDatetime.subtract(Duration(days: i));
        // NOTE: ハッシュ値が year + month + day なので DateTime のまま追加できる！
        if (kEvents.containsKey(dt)) {
          kEvents[dt]!.add(_EmptyTruckEvent(data['truck_id']));
        } else {
          kEvents[dt] = [_EmptyTruckEvent(data['truck_id'])];
        }
      }

      _selectedEvents.value = _getEventsForDay(_selectedDay!);
      setState(() {});
    }
  }

  /// Firestore から全てのトラックを取得する。
  void _getTrucks() async {
    var qs = await FirebaseFirestore.instance.collection("${MyUser.getCompanyCode()}-trucks").get();
    _trucks = qs.docs;
    setState(() {});
  }

  List<_EmptyTruckEvent> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('空きトラック検索'),
        // TODO: 再読み込みボタン
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'ja_JP',
            daysOfWeekHeight: 24,
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });

                _selectedEvents.value = _getEventsForDay(selectedDay);
              }
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<_EmptyTruckEvent>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                var event = value.map((v) => v.toString());
                var emptyTrucks = _trucks.where((truck) => !event.contains(truck.id)).toList();

                return ListView.builder(
                  itemCount: emptyTrucks.length,
                  itemBuilder: (context, index) {
                    var emptyTruck = emptyTrucks[index];
                    if (emptyTruck.exists) {
                      var data = emptyTruck.data();
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => print('${emptyTrucks[index]}'),
                          title: Text(data['car_number']),
                        ),
                      );
                    } else {
                      // 存在しない時
                      // TODO: UI
                      return Text('error');
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
