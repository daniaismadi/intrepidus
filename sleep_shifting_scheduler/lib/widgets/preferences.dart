import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sleep_shifting_scheduler/widgets/dock-undock.dart';
import 'custom_widget/confirm.dart';
import 'custom_widget/switch.dart';

class Preference extends StatefulWidget {
  @override
  _PreferenceState createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  bool _switchValue1 = true;
  bool _switchValue2 = false;

  String str1 = "I'd like to take melatonin";
  String str2 = "I'm using prescription medication";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: new EdgeInsets.fromLTRB(20, 100, 20, 10),
              padding: new EdgeInsets.fromLTRB(5, 20, 5, 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              alignment: Alignment(0, 0),
              height: 400,
              child: ListView(
                children: <Widget>[
                  Text('Let me know your preferences',
                      style: TextStyle(fontSize: 26),
                      textAlign: TextAlign.center),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  LabeledSwitch(
                    label: str1,
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    value: _switchValue1,
                    activeColor: Colors.blue,
                    onChanged: (bool newValue) {
                      setState(() {
                        _switchValue1 = newValue;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  LabeledSwitch(
                    label: str2,
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    value: _switchValue2,
                    activeColor: Colors.blue,
                    onChanged: (bool newValue) {
                      setState(() {
                        _switchValue2 = newValue;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Please specify'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [SvgPicture.asset('lib/images/logo.svg')]),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(-0.8, 1.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.blue),
              backgroundColor: Colors.white,
              elevation: 10.0,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ConfirmButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DockingWidget()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
