import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:sleep_shifting_scheduler/api/EventModel.dart';

class CalenderWidget extends StatefulWidget {
  CalenderWidget({Key key}) : super(key: key);

  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  var months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  DateTime _currentDate = DateTime.now();
  int scrollMonth = DateTime.now().month;

  EventList<Event> _markedDateMap = EventListModel(fromMap: {
    DateTime(2020, 10, 5).toIso8601String(): [
      {
        'eventId': '1',
        'description': 'Some Description',
        'eventTitle': 'hello world',
        'color': '#D8122F',
        'dateTime': DateTime.now().toIso8601String(),
      },
      {
        'eventId': '2',
        'description': 'Some Description',
        'eventTitle': 'hello world',
        'color': '#aabbcc',
        'dateTime': DateTime.now().toIso8601String(),
      },
      {
        'eventId': '3',
        'description': 'Some Description',
        'eventTitle': 'hello world',
        'color': '#D8122F',
        'dateTime': DateTime.now().toIso8601String(),
      }
    ],
    DateTime(2020, 10, 4).toIso8601String(): [
      {
        'eventId': '1',
        'description': 'Some Description',
        'eventTitle': 'hello world',
        'color': '#aabbcc',
        'dateTime': DateTime.now().toIso8601String(),
      },
      {
        'eventId': '2',
        'description': 'Some Description',
        'eventTitle': 'hello world',
        'color': '#D8122F',
        'dateTime': DateTime.now().toIso8601String(),
      },
      {
        'eventId': '3',
        'description': 'Some Description',
        'eventTitle': 'hello world',
        'color': '#aabbcc',
        'dateTime': DateTime.now().toIso8601String(),
      }
    ]
  }).eventList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Color(0XFF074EE8),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                months[scrollMonth],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: (['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'])
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          e,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        Container(
          color: Color(0XFFE0EAFF),
          child: CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              this.setState(() => _currentDate = date);
            },
            showHeaderButton: false,
            headerMargin: EdgeInsets.all(35),
            childAspectRatio: 1.2,
            headerTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            showHeader: false,
            onCalendarChanged: (DateTime a) {
              setState(() => scrollMonth = a.month);
            },
            showWeekDays: false,
            weekendTextStyle: TextStyle(color: Colors.black),
            daysTextStyle: TextStyle(color: Colors.black),
            weekDayFormat: WeekdayFormat.standaloneShort,
            weekdayTextStyle: TextStyle(color: Colors.black),
            height: 280,
            weekFormat: false,
            nextMonthDayBorderColor: Colors.black,
            daysHaveCircularBorder: null,
            markedDatesMap: _markedDateMap,
            selectedDateTime: _currentDate,
          ),
        ),
      ],
    );
  }
}
