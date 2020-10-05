import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:sleep_shifting_scheduler/api/EventModel.dart';
import 'package:sleep_shifting_scheduler/api/ExerciseModel.dart';
import 'package:sleep_shifting_scheduler/api/MealModel.dart';
import 'package:sleep_shifting_scheduler/constants.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:sleep_shifting_scheduler/database/databaseFunctions.dart';
import 'package:sleep_shifting_scheduler/widgets/settings.dart';

class CalenderWidget extends StatefulWidget {
  CalenderWidget({Key key}) : super(key: key);

  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget>
    with SingleTickerProviderStateMixin {
  static EventListModel _markedDate;
  static ExcerciseModel _exerciseModel;
  static MealModel _mealModel;

  DateTime _currentDate = DateTime.now();
  int scrollMonth = DateTime.now().month;

  List<EventModel> eventLists;
  List<Map<String, int>> exerciseList;
  List<Meal> mealLists;
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    callEvents();
    super.initState();
  }

  callEvents() async {
    _markedDate = await DatabaseFunctions().readUserEvents('1601752362217');
    _exerciseModel =
        await DatabaseFunctions().readUserExercise('1601752362217');
    _mealModel = await DatabaseFunctions().readUserMeals('1601752362217');
    return _markedDate;
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsWidget(),
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: callEvents(),
          builder: (context, AsyncSnapshot<void> _) {
            if (_.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CalendarHeader(
                      size: size, months: cMonths, scrollMonth: scrollMonth),
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
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      onDayPressed: (DateTime date, List<Event> events) {
                        setState(() {
                          _currentDate = date;
                          eventLists =
                              _markedDate.getEventModelList(_currentDate);
                          exerciseList =
                              _exerciseModel.getTodayExercise(_currentDate);
                          mealLists = _mealModel.getTodayMeals(_currentDate);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        ScheduleView(eventLists: eventLists),
                        MealView(mealLists: mealLists),
                        ExerciseView(exerciseList: exerciseList),
                      ],
                    ),
                  ),
                  BottomTabs(tabController: tabController)
                ],
              );
            } else {
              return Container();
            }
          },
        ));
  }
}

class MealView extends StatelessWidget {
  const MealView({
    Key key,
    @required this.mealLists,
  }) : super(key: key);

  final List<Meal> mealLists;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_food_beverage,
                color: Color(0XFF074EE8),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'Meals',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF074EE8)),
                ),
              ),
            ],
          ),
          Expanded(
            child: mealLists == null
                ? Center(child: Text('No meals for you'))
                : ListView(
                    padding: EdgeInsets.all(0),
                    children: mealLists
                        .map(
                          (Meal m) => ExpansionTile(
                            childrenPadding: EdgeInsets.all(10),
                            title: Text(
                              m.title,
                              style: TextStyle(fontSize: 20),
                            ),
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: m.foodList
                                      .map(
                                        (String e) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

class ExerciseView extends StatelessWidget {
  final List<Map<String, int>> exerciseList;
  ExerciseView({this.exerciseList, key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports,
              size: 30,
              color: Color(0XFF074EE8),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Workout Routine',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF074EE8),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: exerciseList == null
              ? Center(child: Text('Still, no cake please...'))
              : ListView(
                  padding: EdgeInsets.all(0),
                  children: exerciseList
                      .map(
                        (Map<String, int> e) => ListTile(
                          title: Text(
                            e.keys.first,
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Text(
                            '${e.values.first.toString()} min',
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
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
                  .map(
                    (EventModel e) => EventsListTiles(e: e),
                  )
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
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DateTimeToTextWidget(e: e.dateTime),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(Icons.arrow_downward, color: Colors.white, size: 15),
            ),
            DateTimeToTextWidget(e: e.until),
          ],
        ),
      ),
      color: e.colorFromString(),
    );
  }
}

class DateTimeToTextWidget extends StatelessWidget {
  const DateTimeToTextWidget({
    Key key,
    @required this.e,
  }) : super(key: key);

  final DateTime e;

  @override
  Widget build(BuildContext context) {
    return Text(
      (e.hour > 10 ? e.hour.toString() : '0' + e.hour.toString()) +
          (e.minute > 10 ? e.minute.toString() : '0' + e.minute.toString()),
      style: TextStyle(color: Colors.white),
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
