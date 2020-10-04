import 'dart:collection';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

  Future<Map> readUser(String path, String key) async {
    DatabaseReference user = db.child(path + '/' + key);
    String userId;
    String name;
    user.once().then((snapshot) {
      userId = snapshot.value['id'];
      name = snapshot.value['name'];
    });

    Map<String, dynamic> userMap = {};

    print(userMap.runtimeType);
  }
}
