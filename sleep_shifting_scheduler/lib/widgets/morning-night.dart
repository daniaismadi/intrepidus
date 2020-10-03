import 'package:flutter/material.dart';
import 'custom_widget/morning.dart';
import 'custom_widget/night.dart';
import 'intrepidus.dart';
import 'preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MornNight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: new EdgeInsets.fromLTRB(20, 120, 20, 40),
              padding: new EdgeInsets.fromLTRB(5, 20, 5, 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              alignment: Alignment(0, 0),
              height: 400,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  Text('Which one are you?',
                      style: TextStyle(fontSize: 24, fontFamily: 'Segoe-UI'),
                      textAlign: TextAlign.center),
                  Padding(
                    padding: EdgeInsets.all(30),
                  ),
                  MorningButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  NightButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Preference()),
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [SvgPicture.asset('assets/logo.svg')]),
            ),
          ],
        ),
      ),
    );
  }
}
