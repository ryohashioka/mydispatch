import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mydispatch/data/ScheduleSearch.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class _ReservationEvent {
  final String title;

  const _ReservationEvent(this.title);

  @override
  String toString() => title;
}

class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  late final ValueNotifier<List<_ReservationEvent>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  var kEvents = LinkedHashMap<DateTime, List<_ReservationEvent>>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll({
    DateTime.now(): [const _ReservationEvent('Event1'), const _ReservationEvent('Event2')],
    DateTime.now().add(const Duration(days:2)): [const _ReservationEvent('Event3')],
    DateTime.now().add(const Duration(hours:2)): [const _ReservationEvent('Event4')],
  });

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    _getSchedules();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  /// Firestore からスケジュールデータを取得する。
  void _getSchedules() async {
    var querySnapshot = await ScheduleSearch().exec();
    Map<DateTime, List<_ReservationEvent>> eventMap = {};
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      // 日跨ぎのデータを考慮し、start と end の差分を取得して連続追加
      DateTime startDatetime = data['start_datetime'].toDate();
      DateTime endDatetime = data['end_datetime'].toDate();
      int dayOfDiff = endDatetime.difference(startDatetime).inDays; // 日付の差分（end - start）
      for (int i=0; i<=dayOfDiff.abs(); i++) {
        // end の方が古ければ引き算
        DateTime dt = dayOfDiff > 0 ? startDatetime.add(Duration(days: i)) : startDatetime.subtract(Duration(days: i));
        // NOTE: ハッシュ値が year + month + day なので DateTime のまま追加できる！
        if (kEvents.containsKey(dt)) {
          kEvents[dt]!.add(_ReservationEvent(data['CarNumber']));
        } else {
          kEvents[dt] = [_ReservationEvent(data['CarNumber'])];
        }
      }

      _selectedEvents.value = _getEventsForDay(_selectedDay!);
      setState(() {});
    }
  }

  List<_ReservationEvent> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation'),
        // TODO: 再読み込みボタン
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'ja_JP',
            daysOfWeekHeight: 18,
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
            child: ValueListenableBuilder<List<_ReservationEvent>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
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
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
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
