import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sleep_shifting_scheduler/widgets/console-shifts.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickDate.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickLocation.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickTime.dart';

class DockingWidget extends StatefulWidget {
  final Map<String, dynamic> dataMap;
  DockingWidget(this.dataMap);
  @override
  _DockingWidgetState createState() => _DockingWidgetState();
}

class _DockingWidgetState extends State<DockingWidget> {
  DateTime departureDate = DateTime.now();
  DateTime dockDate = DateTime.now();
  DateTime undockDate = DateTime.now();

  TimeOfDay departureDeparture = TimeOfDay.now();
  TimeOfDay dockingArrival = TimeOfDay.now();
  TimeOfDay undockDeparture = TimeOfDay.now();
  TimeOfDay undockArrival = TimeOfDay.now();
  int location;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 2,
                      margin: new EdgeInsets.fromLTRB(20, 100, 20, 10),
                      padding: new EdgeInsets.fromLTRB(5, 10, 5, 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(7, 78, 232, 1.0), width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: buildFields(),
                    ),
                  ],
                ),
              ),
              // Bottom widgets.
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SheepLog(),
                    BottomNavBar(
                      confirmButton: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConsoleWidget({
                              'isMorningPerson':
                                  widget.dataMap['isMorningPerson'],
                              'likeMelatonin': widget.dataMap['likeMelatonin'],
                              'medicine': widget.dataMap['medicine'],
                              'preferences': widget.dataMap['preferences'],
                              'departureDate': departureDate,
                              'dockDate': dockDate,
                              'undockDate': undockDate,
                              'departureDeparture': departureDeparture,
                              'dockingArrival': dockingArrival,
                              'undockDeparture': undockDeparture,
                              'undockArrival': undockArrival,
                              'location': location,
                            }),
                          ),
                        )
                      },
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

  Widget buildFields() {
    return ListView(padding: EdgeInsets.all(0), children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          'When are you docking and undocking?',
          style: TextStyle(fontSize: 20, fontFamily: 'Segoe-UI'),
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(height: 7),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        new PickDateWidget(
          dateType: 'Departure Date',
          pickDate: (newDate) => setState(() => departureDate = newDate),
        ),
        new PickTimeWidget(
          timeType: 'Departure',
          pickTime: (newTime) => setState(() => departureDeparture = newTime),
        )
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        new PickDateWidget(
          dateType: 'Docking Date',
          pickDate: (newDate) => setState(() => dockDate = newDate),
        ),
        new PickTimeWidget(
          timeType: 'Arrival',
          pickTime: (newTime) => setState(() => dockingArrival = newTime),
        )
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        new PickDateWidget(
          dateType: 'Undocking Date',
          pickDate: (newDate) => setState(() => undockDate = newDate),
        ),
        new PickTimeWidget(
          timeType: 'Departure',
          pickTime: (newTime) => setState(() => undockDeparture = newTime),
        ),
        new PickTimeWidget(
          timeType: 'Arrival',
          pickTime: (newTime) => setState(() => undockArrival = newTime),
        ),
      ]),
      new PickLocation((int timezone) => setState(() => location = timezone))
    ]);
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    this.confirmButton,
    Key key,
  }) : super(key: key);

  final Function confirmButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: new Icon(CupertinoIcons.arrow_left,
                color: Color.fromRGBO(7, 78, 232, 1.0)),
            onPressed: () => Navigator.pop(context),
          ),
          RaisedButton(
            onPressed: confirmButton,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            color: Color.fromRGBO(7, 78, 232, 1.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Confirm',
                style: TextStyle(fontFamily: 'Segoe-UI', fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SheepLog extends StatelessWidget {
  const SheepLog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SvgPicture.asset('lib/images/intrepiduslogo180px.svg',
            width: 90, height: 90)
      ]),
    );
  }
}
