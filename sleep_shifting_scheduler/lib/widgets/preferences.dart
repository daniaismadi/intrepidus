import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_shifting_scheduler/widgets/dock-undock.dart';
import 'custom_widget/switch.dart';

class Preference extends StatefulWidget {
  final bool isMorningPerson;
  Preference(this.isMorningPerson);
  @override
  _PreferenceState createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  bool _switchValue1 = true;
  bool _switchValue2 = false;
  TextEditingController textController = TextEditingController();
  String str1 = "I'd like to take melatonin";
  String str2 = "I'm using prescription medication";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 2,
                      margin: new EdgeInsets.fromLTRB(20, 100, 20, 10),
                      padding: new EdgeInsets.fromLTRB(5, 0, 5, 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(7, 78, 232, 1.0), width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(24),
                              child: Text('Let me know your preferences',
                                  style: TextStyle(fontSize: 26),
                                  textAlign: TextAlign.center),
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
                                controller: textController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Please specify'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SheepLog(),
                    BottomNavBar(
                      confirmButton: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DockingWidget(
                            {
                              'isMorningPerson': widget.isMorningPerson,
                              'likeMelatonin': _switchValue1,
                              'medicine': _switchValue2,
                              'preferences': textController.text.toString(),
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
