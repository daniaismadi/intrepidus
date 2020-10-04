import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickDate.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickLocation.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickTime.dart';

class DockingWidget extends StatefulWidget {
  @override
  _DockingWidgetState createState() => _DockingWidgetState();
}

class _DockingWidgetState extends State<DockingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: new EdgeInsets.fromLTRB(0, 0, 0, 30),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // shrinkWrap: true,
          // padding: const EdgeInsets.only(top: 130),
          children: [
            Center(
                child: Container(
                    margin: new EdgeInsets.fromLTRB(20, 100, 20, 10),
                    padding: new EdgeInsets.fromLTRB(5, 20, 5, 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(7, 78, 232, 1.0), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    alignment: Alignment(0, 0),
                    height: 360,
                    width: 300,
                    child: buildFields())),
            // Bottom widgets.
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset('lib/images/intrepiduslogo180px.svg',
                            width: 90, height: 90)
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: new Icon(CupertinoIcons.arrow_left,
                              color: Color.fromRGBO(7, 78, 232, 1.0)),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          color: Color.fromRGBO(7, 78, 232, 1.0),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              child: const Text('Confirm',
                                  style: TextStyle(
                                      fontFamily: 'Segoe-UI', fontSize: 15))))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFields() {
    return ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          'When are you docking and undocking?',
          style: TextStyle(fontSize: 20, fontFamily: 'Segoe-UI'),
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(height: 7),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        new PickDateWidget(dateType: 'Departure Date'),
        new PickTimeWidget(timeType: 'Departure')
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        new PickDateWidget(dateType: 'Docking Date'),
        new PickTimeWidget(timeType: 'Arrival')
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        new PickDateWidget(dateType: 'Undocking Date'),
        new PickTimeWidget(timeType: 'Departure'),
        new PickTimeWidget(timeType: 'Arrival'),
      ]),
      new PickLocation()
    ]);
  }
}
