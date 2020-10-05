import 'package:flutter/material.dart';
import 'package:sleep_shifting_scheduler/database/databaseFunctions.dart';
import 'package:sleep_shifting_scheduler/widgets/calendar.dart';
import 'package:sleep_shifting_scheduler/widgets/intrepidus.dart';
import 'package:sleep_shifting_scheduler/widgets/settings.dart';

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
      home: MyHomePage(),
    );
  }
}
