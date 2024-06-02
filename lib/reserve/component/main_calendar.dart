import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';

class MainCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final OnDaySelected onDaySelected;

  const MainCalendar({
    super.key,
    required this.selectedDate,
    required this.onDaySelected,
  });

  @override
  State<MainCalendar> createState() => _MainCalendarState();
}

class _MainCalendarState extends State<MainCalendar> {
  // final events = LinkedHashMap(
  //   equals: isSameDay,
  // )..addAll(eventSource2);
  //
  // // Map<DateTime, List<Event>> events = eventSource;
  //
  // List<Event> _getEventsForDay(DateTime day) {
  //   DateTime asdf = DateTime(day.year, day.month, day.day);
  //   // // print(events[asdf]);
  //   // // print(events[day]);
  //   return events[asdf] ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    // print(events);
    // print(_getEventsForDay(widget.selectedDate));
    return TableCalendar(
      // eventLoader: _getEventsForDay,
      availableGestures: AvailableGestures.none,
      locale: 'ko_kr',
      daysOfWeekHeight: 40.0,
      focusedDay: widget.selectedDate,
      firstDay: DateTime(2000, 1, 1),
      lastDay: DateTime(3000, 1, 1),
      selectedDayPredicate: (DateTime dateTime) {
        return dateTime.year == widget.selectedDate.year &&
            dateTime.month == widget.selectedDate.month &&
            dateTime.day == widget.selectedDate.day;
      },
      onDaySelected: widget.onDaySelected,
      headerStyle: getHeaderStyle(),
      calendarStyle: getCalendarStyle(),
      // calendarBuilders: CalendarBuilders(
      //   defaultBuilder: (
      //     BuildContext context,
      //     DateTime day,
      //     DateTime focusedDay,
      //   ) {
      //     return Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         const SizedBox(height: 10.0),
      //         Text(
      //           day.day.toString(),
      //           style: TextStyle(color: Colors.black),
      //         ),
      //         Text(
      //           "10,000,000",
      //           style: smallGreyTextStyle.copyWith(fontSize: 10.0),
      //         ),
      //       ],
      //     );
      //   },
      //   markerBuilder: (
      //     BuildContext context,
      //     DateTime day,
      //     List<Event> events,
      //   ) {
      //     print(events);
      //     String asdasdf = '';
      //     if (events.isNotEmpty) {
      //       asdasdf = convertIntToMoneyString(number: events.first.amount);
      //     }
      //     return Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 5.0),
      //       child: Text(
      //         asdasdf,
      //         style: smallGreyTextStyle.copyWith(fontSize: 9.0),
      //       ),
      //     );
      //   },
      // ),
    );
  }

  HeaderStyle getHeaderStyle() {
    return const HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
      titleTextStyle: MyTextStyle.bodyMedium,
    );
  }

  CalendarStyle getCalendarStyle() {
    return CalendarStyle(
      cellMargin: const EdgeInsets.all(4),
      // markerMargin: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 0.3),
      isTodayHighlighted: false,
      defaultDecoration: BoxDecoration(
        color: MyColor.lightGrey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      weekendDecoration: BoxDecoration(
        color: MyColor.lightGrey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      selectedDecoration: BoxDecoration(
        // color: PRIMARY_COLOR,
        border: Border.all(
          color: MyColor.primary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      defaultTextStyle: MyTextStyle.descriptionMedium,
      weekendTextStyle: MyTextStyle.descriptionMedium,
      selectedTextStyle: MyTextStyle.descriptionMedium.copyWith(
        color: MyColor.primary,
      ),

//       // marker 여러개 일 때 cell 영역을 벗어날지 여부
//       canMarkersOverflow: true,
//
// // 자동정렬 여부
//       markersAutoAligned: true,
//
// // marker 크기 조절
//       markerSize: 8.0,
//
// // marker 크기 비율 조절
//       markerSizeScale: 10.0,
//
// // marker 의 기준점 조정
//       markersAnchor: 0.7,
//
// // marker margin 조절
//       markerMargin: const EdgeInsets.symmetric(horizontal: 0.3),
//
// // marker 위치 조정
//       markersAlignment: Alignment.bottomCenter,
//
// // 한줄에 보여지는 marker 갯수
//       markersMaxCount: 4,
//
// //
//       markersOffset: const PositionedOffset(),
//
// // marker 모양 조정
//       markerDecoration: const BoxDecoration(
//         color: Colors.black,
//         shape: BoxShape.circle,
//       ),
    );
  }
}

class Event {
  int amount;

  Event(
    this.amount,
  );

  @override
  String toString() => amount.toString();
}

Map<DateTime, List<Event>> eventSource2 = {
  DateTime(2023, 10, 1): [Event(1234234)],
  DateTime(2023, 10, 2): [Event(2344232)],
  DateTime(2023, 10, 3): [Event(2535333)],
  DateTime(2023, 10, 4): [Event(4444443)],
};

// Map<DateTime, List<Event>> eventSource2 = {
//   DateTime(2023, 10, 2): [Event(1234123)],
//   DateTime(2023, 10, 5): [Event(2342342)],
//   DateTime(2023, 10, 8): [Event(3452341)],
//   DateTime(2023, 10, 11): [Event(1234235)],
//   DateTime(2023, 10, 13): [Event(5435234)],
//   DateTime(2023, 10, 15): [Event(5453534)],
//   DateTime(2023, 10, 18): [Event(2345544)],
//   DateTime(2023, 10, 20): [Event(4564563)],
//   DateTime(2023, 10, 21): [Event(7777777)],
// };

class Event1 {
  String title;
  bool complete;

  Event1(
    this.title,
    this.complete,
  );

  @override
  String toString() => title;
}

Map<DateTime, List<Event1>> eventSource = {
  DateTime(2023, 10, 2): [
    Event1('5분 기도하기', false),
    Event1('교회 가서 인증샷 찍기', true),
    Event1('QT하기', true),
    Event1('셀 모임하기', false),
  ],
  DateTime(2023, 10, 5): [
    Event1('5분 기도하기', false),
    Event1('치킨 먹기', true),
    Event1('QT하기', true),
    Event1('셀 모임하기', false),
  ],
  DateTime(2023, 10, 8): [
    Event1('5분 기도하기', false),
    Event1('자기 셀카 올리기', true),
    Event1('QT하기', false),
    Event1('셀 모임하기', false),
  ],
  DateTime(2023, 10, 11): [
    Event1('5분 기도하기', false),
    Event1('가족과 저녁식사 하기', true),
    Event1('QT하기', true)
  ],
  DateTime(2023, 10, 13): [
    Event1('5분 기도하기', false),
    Event1('교회 가서 인증샷 찍기', true),
    Event1('QT하기', false),
    Event1('셀 모임하기', false),
  ],
  DateTime(2023, 10, 15): [
    Event1('5분 기도하기', false),
    Event1('치킨 먹기', false),
    Event1('QT하기', true),
    Event1('셀 모임하기', false),
  ],
  DateTime(2023, 10, 18): [
    Event1('5분 기도하기', false),
    Event1('자기 셀카 올리기', true),
    Event1('QT하기', false),
    Event1('셀 모임하기', false),
  ],
  DateTime(2023, 10, 20): [
    Event1('5분 기도하기', true),
    Event1('자기 셀카 올리기', true),
    Event1('QT하기', true),
    Event1('셀 모임하기', true),
  ],
  DateTime(2023, 10, 21): [
    Event1('5분 기도하기', false),
    Event1('가족과 저녁식사 하기', true),
    Event1('QT하기', false)
  ]
};
