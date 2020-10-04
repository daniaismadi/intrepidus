import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sleep_shifting_scheduler/api/EventModel.dart';
import 'package:sleep_shifting_scheduler/api/ExerciseModel.dart';
import 'package:sleep_shifting_scheduler/api/MealModel.dart';

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

  Future<MealModel> readUserMeals(String userId) async {
    Map<String, dynamic> rawData;
    Map<String, List<Map<String, List<String>>>> userMeals = {};
    await db
        .child('users/' + userId + '/meal/')
        .once()
        .then((snapshot) => rawData = Map<String, List>.from(snapshot.value));

    rawData.forEach((key, value) {
      List<Map> mealList = List<Map>.from(value);

      List<Map<String, List<String>>> finalMealList = [];

      Map<String, List<String>> meal = {};

      mealList.forEach((element) {
        Map<String, List<dynamic>> tempMeal =
            Map<String, List<dynamic>>.from(element);
        tempMeal.forEach((mealTitle, foodList) {
          meal[mealTitle] = List<String>.from(foodList);
        });

        finalMealList.add(meal);
      });

      userMeals[key] = finalMealList;
    });

    print(userMeals);
    return MealModel(fromMap: userMeals);

    // DataSnapshot dataSnapshot =
    //     await db.child('users/' + userId + "/meal/").once();

    // if (dataSnapshot.value != null) {
    //   Map<String, List<Map<String, List<String>>>> userMeals = {};

    //   Map<String, dynamic> rawData = Map<String, List>.from(dataSnapshot.value);

    //   rawData.forEach((key, value) {
    //     List<Map> mealList = List<Map>.from(value);

    //     List<Map<String, List<String>>> finalMealList = [];

    //     Map<String, List<String>> meal = {};

    //     mealList.forEach((element) {
    //       Map<String, List<dynamic>> tempMeal =
    //           Map<String, List<dynamic>>.from(element);
    //       tempMeal.forEach((mealTitle, foodList) {
    //         meal[mealTitle] = List<String>.from(foodList);
    //       });

    //       finalMealList.add(meal);
    //     });

    //     userMeals[key] = finalMealList;
    //   });

    //   return MealModel(fromMap: userMeals);
    // }
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

  // Future<MealModel> readUserMeal(String key) async {
  //   Map userMeal;
  //   await db
  //       .child(DatabaseFunctions.ADD_NEW_USER_PATH + '/' + key)
  //       .once()
  //       .then((value) => userMeal = value.value['meal']);
  //   List<String> listOfKeys =
  //       userMeal.entries.map((e) => e.key.toString()).toList();
  //   List<List> listOfEvents =
  //       userEvent.entries.map((e) => e.value as List).toList();
  // }

  // Future<Map> readUser(String path, String key) async {
  //   DatabaseReference user = db.child(path + '/' + key);
  //   String userId;
  //   String name;
  //   user.once().then((snapshot) {
  //     userId = snapshot.value['id'];
  //     name = snapshot.value['name'];
  //   });

  //   Map<String, dynamic> userMap = {};

  //   print(userMap.runtimeType);
  // }

}
