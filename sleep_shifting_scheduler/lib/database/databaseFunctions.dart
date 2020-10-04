import 'dart:collection';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sleep_shifting_scheduler/api/EventModel.dart';
import 'package:sleep_shifting_scheduler/api/ExerciseModel.dart';

class DatabaseFunctions {
  static const String ADD_NEW_USER_PATH = '/users';
  final db = FirebaseDatabase.instance.reference();

  // Create
  Future<void> addsData<T>(String path, String key, Map value) async =>
      await db.child(path + '/' + key).set(value);
  Future<void> deleteData<T>(String path, String key) async =>
      await db.child(path + '/' + key).remove();
  Future<void> updateData<T>(String path, String key, Map mapValue) async =>
      await db.child(path + '/' + key).set(mapValue);
  Future<Map> readData(String path, String key) async {
    Map returnValue;
    await db
        .child(path + '/' + key)
        .once()
        .then((DataSnapshot snapshot) => returnValue = snapshot.value)
        .catchError((e) => print(e));
    return returnValue;
  }

  Future<EventListModel> readUserEvents(String key) async {
    Map userEvent;
    await db
        .child(DatabaseFunctions.ADD_NEW_USER_PATH + '/' + key)
        .once()
        .then((DataSnapshot value) => userEvent = value.value['event']);
    List<String> listOfKeys =
        userEvent.entries.map((e) => e.key.toString()).toList();
    List<List> listOfEvents =
        userEvent.entries.map((e) => e.value as List).toList();
    List<List<EventModel>> listOfEventModel = listOfEvents
        .map(
          (e) => e
              .map(
                (e) => EventModel(
                  color: e['color'],
                  description: e['description'],
                  eventTitle: e['eventTitle'],
                  until: DateTime.parse(e['until']),
                  dateTime: DateTime.parse(e['dateTime']),
                  eventId: e['eventId'],
                ),
              )
              .toList(),
        )
        .toList();
    Map<DateTime, List<dynamic>> myMap = {};
    for (int i = 0; i < listOfKeys.length; i++) {
      myMap.addEntries(
          [MapEntry(DateTime.parse(listOfKeys[i]), listOfEventModel[i])]);
    }

    return EventListModel(
      thisEventsModelMap: Map<DateTime, List<EventModel>>.from(myMap),
    );
  }
}
