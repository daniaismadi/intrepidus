import 'package:flutter/material.dart';
import 'package:sleep_shifting_scheduler/widgets/dock-undock.dart';
import 'custom_widget/morning.dart';
import 'custom_widget/night.dart';
import 'preferences.dart';

class MornNight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: new EdgeInsets.fromLTRB(20, 120, 20, 40),
                  padding: new EdgeInsets.fromLTRB(5, 20, 5, 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(7, 78, 232, 1.0), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  alignment: Alignment(0, 0),
                  height: 400,
                  child: ListView(
                    padding: EdgeInsets.all(15),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(25),
                      ),
                      Text('Which one are you?',
                          style:
                              TextStyle(fontSize: 24, fontFamily: 'Segoe-UI'),
                          textAlign: TextAlign.center),
                      Padding(
                        padding: EdgeInsets.all(30),
                      ),
                      MorningButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Preference()),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 24),
            child: SheepLog(),
          )
        ],
      ),
    );
  }
}
