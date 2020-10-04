import 'package:flutter/material.dart';
import 'custom_widget/reset.dart';
import 'intrepidus.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Segoe-UI',
            color: Colors.blue[800],
          ),
        ),
        iconTheme: IconThemeData(color: Colors.blue[800]),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Text(
                  'Key',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Segoe-UI',
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 80,
                  margin: new EdgeInsets.fromLTRB(20, 80, 20, 0),
                  padding: new EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: Column(
                    children: <Widget>[
                      Image.asset('lib/images/light.png'),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Text(
                        'prioritise exposure to high intensity blue enriched light',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Segoe-UI',
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  width: 80,
                  margin: new EdgeInsets.fromLTRB(20, 80, 20, 0),
                  padding: new EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: Column(
                    children: <Widget>[
                      Image.asset('lib/images/moon.png'),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Text(
                        'prioritise exposure to low intensity blue depleted light',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Segoe-UI',
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 80,
                  margin: new EdgeInsets.fromLTRB(20, 0, 20, 0),
                  padding: new EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: Column(
                    children: <Widget>[
                      Image.asset('lib/images/coffee.png'),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Text(
                        'meal time',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Segoe-UI',
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  width: 80,
                  margin: new EdgeInsets.fromLTRB(20, 0, 20, 10),
                  padding: new EdgeInsets.fromLTRB(5, 20, 5, 20),
                  child: Column(
                    children: <Widget>[
                      Image.asset('lib/images/activity.png'),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Text(
                        'exercise time',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Segoe-UI',
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ResetButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
