import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_widget/addtrip.dart';
import 'morning-night.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('lib/images/logowords.svg'),
            TripButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MornNight()),
              );
            })
          ],
        ),
      ),
    );
  }
}
