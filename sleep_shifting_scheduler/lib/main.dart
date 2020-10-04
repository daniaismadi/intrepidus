import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleep_shifting_scheduler/widgets/console-shifts.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickTime.dart';
import 'package:sleep_shifting_scheduler/widgets/dock-undock.dart';
import 'widgets/intrepidus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.lightBlueAccent,
        ),
        home: MyHomePage());
  }
}
