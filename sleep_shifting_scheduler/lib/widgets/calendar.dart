import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:sleep_shifting_scheduler/api/EventModel.dart';
import 'package:sleep_shifting_scheduler/constants.dart';

class CalenderWidget extends StatefulWidget {
  CalenderWidget({Key key}) : super(key: key);

  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget>
    with SingleTickerProviderStateMixin {
  DateTime _currentDate = DateTime.now();
  int scrollMonth = DateTime.now().month;
  static EventListModel _markedDate;
  List<EventModel> eventLists;
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    _markedDate = EventListModel(fromMap: {
      DateTime(2020, 10, 5).toIso8601String(): [
        {
          'eventId': '1',
          'description': 'Some Description',
          'eventTitle': 'Open your eyes',
          'color': '219653',
          'dateTime': DateTime.now().toIso8601String(),
        },
        {
          'eventId': '2',
          'description': 'Some Description',
          'eventTitle': 'Eat',
          'color': 'F2C94C',
          'dateTime': DateTime.now().add(Duration(hours: 1)).toIso8601String(),
        },
        {
          'eventId': '3',
          'description': 'Some Description',
          'eventTitle': 'Sleep',
          'color': '074EE8',
          'dateTime': DateTime.now().add(Duration(hours: 2)).toIso8601String(),
        }
      ],
      DateTime(2020, 10, 3).toIso8601String(): [
        {
          'eventId': '1',
          'description': 'Some Description',
          'eventTitle': 'Open your eyes',
          'color': '219653',
          'dateTime': DateTime.now().add(Duration(hours: 1)).toIso8601String(),
        },
        {
          'eventId': '2',
          'description': 'Some Description',
          'eventTitle': 'sleep',
          'color': 'F2C94C',
          'dateTime': DateTime.now().add(Duration(hours: 2)).toIso8601String(),
        },
      ],
    });
    eventLists = _markedDate.getEventModelList(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarHeader(size: size, months: cMonths, scrollMonth: scrollMonth),
          Container(
            color: Color(0XFFE0EAFF),
            child: CalendarCarousel<Event>(
              showHeaderButton: false,
              headerMargin: EdgeInsets.all(35),
              childAspectRatio: 1.0,
              showHeader: false,
              showWeekDays: false,
              weekFormat: false,
              daysHaveCircularBorder: null,
              height: size.height * 2 / 5,
              todayButtonColor: Colors.transparent,
              nextMonthDayBorderColor: Colors.black,
              markedDatesMap: _markedDate.eventList,
              weekendTextStyle: TextStyle(color: Colors.black),
              daysTextStyle: TextStyle(color: Colors.black),
              weekDayFormat: WeekdayFormat.standaloneShort,
              weekdayTextStyle: TextStyle(color: Colors.black),
              selectedDayButtonColor: Colors.grey.withOpacity(0.3),
              selectedDateTime: _currentDate,
              headerTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              onCalendarChanged: (DateTime a) =>
                  setState(() => scrollMonth = a.month),
              selectedDayTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
              todayTextStyle: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
              onDayPressed: (DateTime date, List<Event> events) {
                setState(() {
                  _currentDate = date;
                  eventLists = _markedDate.getEventModelList(_currentDate);
                });
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ScheduleView(eventLists: eventLists),
                Container(),
                Container()
              ],
            ),
          ),
          BottomTabs(tabController: tabController)
        ],
      ),
    );
  }
}

class ScheduleView extends StatelessWidget {
  const ScheduleView({
    Key key,
    @required this.eventLists,
  }) : super(key: key);

  final List<EventModel> eventLists;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: eventLists == null
          ? Center(child: Text('No events for today'))
          : ListView(
              padding: EdgeInsets.all(0),
              children: eventLists
                  .map((EventModel e) => EventsListTiles(e: e))
                  .toList(),
            ),
    );
  }
}

class EventsListTiles extends StatelessWidget {
  final EventModel e;
  const EventsListTiles({Key key, this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: ListTile(
        tileColor: Colors.transparent,
        title: Text(
          e.eventTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(e.description, style: TextStyle(color: Colors.white)),
        trailing: Text(
          '${e.dateTime.hour}:${e.dateTime.minute}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      color: e.colorFromString(),
    );
  }
}

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    Key key,
    @required this.size,
    @required this.months,
    @required this.scrollMonth,
  }) : super(key: key);

  final Size size;
  final List<String> months;
  final int scrollMonth;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFF074EE8),
      height: size.height / 5,
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
          SizedBox(height: 20),
          CalenderWeekLabels(),
        ],
      ),
    );
  }
}

class BottomTabs extends StatelessWidget {
  const BottomTabs({
    Key key,
    @required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: TabBar(
        indicatorColor: Color(0XFF074EE8),
        labelColor: Colors.black,
        controller: tabController,
        tabs: [
          Tab(child: Text('Schedule')),
          Tab(child: Text('Nutrition')),
          Tab(child: Text('Workout')),
        ],
      ),
    );
  }
}

class CalenderWeekLabels extends StatelessWidget {
  const CalenderWeekLabels({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
