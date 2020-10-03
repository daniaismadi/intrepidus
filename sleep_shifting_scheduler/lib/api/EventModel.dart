import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class EventListModel {
  /* A list of events */
  // EventList<Event> is used in calender;
  EventList<Event> thisEventsList;
  Map<DateTime, List<EventModel>> thisEventsModelMap;
  // Generates a map
  Map<String, List<Map<String, dynamic>>> fromMap;

  EventListModel({this.thisEventsModelMap, this.fromMap}) {
    // Initialize the ListModel with Map from database
    if (fromMap != null) {
      thisEventsList = EventList(
        events: fromMap.map(
          (String date, List<Map<String, dynamic>> value) => MapEntry(
            DateTime.parse(date),
            value
                .map((Map<String, dynamic> e) =>
                    EventModel(fromMap: e).thisEvent)
                .toList(),
          ),
        ),
      );
      thisEventsModelMap = fromMap.map(
        (String key, List<Map<String, dynamic>> value) => MapEntry(
          DateTime.parse(key),
          value.map((e) => EventModel(fromMap: e)).toList(),
        ),
      );
    } else {
      // Generate the EventList from thisEventsModelMap when we dont have Map from Database
      thisEventsList = EventList(
        events: thisEventsModelMap.map(
          (DateTime key, List<EventModel> value) => MapEntry(
            key,
            value.map((EventModel e) => e.thisEvent).toList(),
          ),
        ),
      );
    }
  }
  // Generates the map
  Map<String, List<Map<String, dynamic>>> toMap() {
    return thisEventsModelMap.map(
      (DateTime key, List<EventModel> value) => MapEntry(
        key.toIso8601String().substring(0, 19),
        value.map((EventModel e) => e.getMap()).toList(),
      ),
    );
  }

  List<EventModel> getEventModelList(DateTime day) => thisEventsModelMap[day];

  EventList<Event> get eventList => thisEventsList;
}

class EventModel {
  /* A single event object*/
  String eventId;
  String eventTitle;
  String description;
  DateTime dateTime;
  String color;
  Map<String, dynamic> fromMap;
  // Event is used in the calender
  Event thisEvent;

  EventModel({
    this.color,
    this.eventTitle,
    this.description,
    this.dateTime,
    this.eventId,
    this.fromMap,
  }) {
    // We can put in a Map from database to build this object
    if (fromMap != null) {
      eventId = fromMap['eventId'];
      eventTitle = fromMap['eventTitle'];
      description = fromMap['description'];
      dateTime = DateTime.parse(fromMap['dateTime']);
      color = fromMap['color'];
    }
    // otherwise we just need to create the objects by passing in the params
    initEvent();
  }

  // Initializes Event object which will be used in the calender widget
  void initEvent() => thisEvent = Event(
        date: dateTime,
        icon: Icon(Icons.add),
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          color: colorFromString(),
          height: 5.0,
          width: 5.0,
        ),
      );

  // Converts color from hexString to Color
  Color colorFromString() {
    final buffer = StringBuffer();
    if (color.length == 6 || color.length == 7) buffer.write('ff');
    buffer.write(color.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // Generates a map object
  Map<String, dynamic> getMap() => {
        'eventId': eventId,
        'eventTitle': eventTitle,
        'color': color,
        'dateTime': dateTime.toIso8601String(),
        'description': description,
      };

  //Some other getters
  Event get event => thisEvent;
  String get eventDescription => description;
  Color get eventEolor => colorFromString();
  DateTime get eventTime => dateTime;
  String get currentEventId => eventId;
}
