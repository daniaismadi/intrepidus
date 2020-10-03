import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

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
  EventList _markedDateMap = EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: Icon(Icons.add_a_photo_rounded),
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: Icon(Icons.ac_unit),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: Icon(Icons.ac_unit),
        ),
      ],
    },
  );
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Sun',
                          style: TextStyle(fontSize: 16, color: Colors.white))),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Mon',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Tue',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Wed',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Thu',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Fri',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Sat',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              )
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
