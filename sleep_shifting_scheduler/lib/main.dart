import 'package:flutter/material.dart';
import 'package:sleep_shifting_scheduler/api/EventModel.dart';
import 'package:sleep_shifting_scheduler/api/UserModel.dart';
import 'package:sleep_shifting_scheduler/database/databaseFunctions.dart';
import 'package:sleep_shifting_scheduler/widgets/calendar.dart';
import 'package:sleep_shifting_scheduler/widgets/intrepidus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Testing(),
    );
  }
}

class Testing extends StatelessWidget {
  final DatabaseFunctions myDatabase = DatabaseFunctions();

  UserModel thisUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Buzz Aldrian',
      event: {
        DateTime(2020, 10, 5).toIso8601String().substring(0, 19): [
          {
            'eventId': '1',
            'description': 'Some Description',
            'eventTitle': 'Open your eyes',
            'color': '219653',
            'dateTime': DateTime.now().toIso8601String(),
            'until': DateTime.now().add(Duration(minutes: 20)).toIso8601String()
          },
          {
            'eventId': '2',
            'description': 'Some Description',
            'eventTitle': 'Eat',
            'color': 'F2C94C',
            'dateTime':
                DateTime.now().add(Duration(hours: 1)).toIso8601String(),
            'until': DateTime.now()
                .add(Duration(hours: 1, minutes: 20))
                .toIso8601String(),
          },
          {
            'eventId': '3',
            'description': 'Some Description',
            'eventTitle': 'Sleep',
            'color': '074EE8',
            'dateTime':
                DateTime.now().add(Duration(hours: 2)).toIso8601String(),
            'until': DateTime.now()
                .add(Duration(hours: 2, minutes: 20))
                .toIso8601String(),
          }
        ],
        DateTime(2020, 10, 3).toIso8601String().substring(0, 19): [
          {
            'eventId': '1',
            'description': 'Some Description',
            'eventTitle': 'Open your eyes',
            'color': '219653',
            'dateTime':
                DateTime.now().add(Duration(hours: 1)).toIso8601String(),
            'until': DateTime.now()
                .add(Duration(hours: 1, minutes: 20))
                .toIso8601String(),
          },
          {
            'eventId': '2',
            'description': 'Some Description',
            'eventTitle': 'sleep',
            'color': 'F2C94C',
            'dateTime':
                DateTime.now().add(Duration(hours: 2)).toIso8601String(),
            'until': DateTime.now()
                .add(Duration(hours: 2, minutes: 20))
                .toIso8601String(),
          },
        ],
      },
      exercise: {
        DateTime(2020, 10, 5).toIso8601String().substring(0, 19): [
          {'ThreadMill': 40},
          {'Cycle': 40},
          {'Streaching': 40},
        ],
        DateTime(2020, 10, 3).toIso8601String().substring(0, 19): [
          {'ThreadMill': 40},
          {'Cycle': 40},
          {'Streaching': 40},
        ],
      },
      meal: {
        DateTime(2020, 10, 5).toIso8601String().substring(0, 19): [
          {
            'Meal A': ['Food', 'Grain', 'Jelly', 'Something else'],
          },
          {
            'Meal B': ['Food', 'Grain', 'Jelly', 'Something else']
          },
          {
            'Meal C': ['Food', 'Grain', 'Jelly', 'Something else']
          },
        ],
        DateTime(2020, 10, 3).toIso8601String().substring(0, 19): [
          {
            'Meal A': ['Food', 'Grain', 'Jelly', 'Something else']
          },
          {
            'Meal B': ['Food', 'Grain', 'Jelly', 'Something else']
          },
          {
            'Meal C': ['Food', 'Grain', 'Jelly', 'Something else']
          },
        ]
      });
  UserModel retrivedUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                color: Colors.blue,
                child: Icon(Icons.wallet_giftcard),
                onPressed: () async {
                  await DatabaseFunctions().addsData(
                      DatabaseFunctions.ADD_NEW_USER_PATH,
                      thisUser.id,
                      thisUser.toMap());
                }),
            RaisedButton(
                color: Colors.blue,
                child: Icon(Icons.wallet_giftcard),
                onPressed: () async {
                  var q = thisUser.toMap();
                  print(q.runtimeType is Map);
                }),
            RaisedButton(
                color: Colors.blue,
                child: Icon(Icons.wallet_giftcard),
                onPressed: () async {
                  await DatabaseFunctions()
                      .updateData('/', 'hello4', {'hello2': 'yes'});
                }),
            RaisedButton(
                color: Colors.blue,
                child: Icon(Icons.wallet_giftcard),
                onPressed: () async {
                  var a = await DatabaseFunctions().readData(
                    DatabaseFunctions.ADD_NEW_USER_PATH,
                    '1601752362217',
                  );
                  UserModel retrieved = UserModel(
                    id: a['id'],
                    name: a['name'],
                    meal: a['meal'],
                    event: a['event'],
                    exercise: a['exercise'],
                  );
                  Map<String, List<Map<String, int>>> exerciseMap = {};
                  print(retrieved.exercise.map().toList());
                  print(retrieved.toMap());
                }),
          ],
        ),
      ),
    );
  }
}
