import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

  Future getAllMeals(String userId) async {
    DataSnapshot dataSnapshot =
        await db.child('users/' + userId + "/meal/").once();

    if (dataSnapshot.value != null) {
      Map<String, List<Map<String, List<String>>>> trial = {};

      Map<String, dynamic> example = Map<String, List>.from(dataSnapshot.value);

      example.forEach((key, value) {
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

        trial[key] = finalMealList;
      });

      return trial;
    }
  }

  MealModel getMeals(String id) {
    MealModel trial;

    getAllMeals(id).then((value) {
      trial = MealModel(fromMap: Map.from(value));
    });

    return trial;
  }

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
