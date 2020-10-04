import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_shifting_scheduler/widgets/calendar.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickDate.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickTime.dart';
import 'package:sleep_shifting_scheduler/widgets/dock-undock.dart';

class ConsoleWidget extends StatefulWidget {
  final Map map;
  ConsoleWidget(this.map);
  @override
  _ConsoleWidgetState createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  List<ConsoleShiftModel> shiftList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: new EdgeInsets.fromLTRB(0, 0, 0, 30),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 400,
                      margin: new EdgeInsets.fromLTRB(20, 100, 20, 10),
                      padding: new EdgeInsets.fromLTRB(5, 20, 5, 20),
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
                      confirmButton: () {
                        InputData(
                          widget.map['isMorningPerson'],
                          widget.map['likeMelatonin'],
                          widget.map['medicine'],
                          widget.map['preferences'],
                          widget.map['departureDate'],
                          widget.map['dockDate'],
                          widget.map['undockDate'],
                          widget.map['departureDeparture'],
                          widget.map['dockingArrival'],
                          widget.map['undockArrival'],
                          widget.map['undockDeparture'],
                          widget.map['location'],
                          shiftList,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalenderWidget(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'List your console shifts',
            style: TextStyle(fontSize: 20, fontFamily: 'Segoe-UI'),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: shiftList.length,
            itemBuilder: (BuildContext context, int index) {
              return buildDateTimeInput(index);
            },
          ),
        ),
        OutlineButton(
          child: new Text(
            '+ Add date and time',
            style: TextStyle(
              color: Color.fromRGBO(7, 78, 232, 1.0),
              fontFamily: 'Segoe-UI',
              fontSize: 12,
            ),
          ),
          shape: new RoundedRectangleBorder(
            side: BorderSide(
              color: Color.fromRGBO(7, 78, 232, 1.0),
              width: 2,
            ),
            borderRadius: new BorderRadius.circular(10),
          ),
          borderSide: BorderSide(
            color: Color.fromRGBO(7, 78, 232, 1.0),
            width: 1,
          ),
          onPressed: () {
            setState(() => shiftList.add(ConsoleShiftModel()));
          },
        )
      ],
    );
  }

  Widget buildDateTimeInput(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new PickDateWidget(
          dateType: 'Date',
          pickDate: (pickedDate) =>
              setState(() => shiftList[index].date = pickedDate),
        ),
        new PickTimeWidget(
          timeType: 'Time',
          pickTime: (pickedTime) =>
              setState(() => shiftList[index].start = pickedTime),
        ),
        new PickTimeWidget(
          timeType: 'Time',
          pickTime: (pickedTime) =>
              setState(() => shiftList[index].end = pickedTime),
        )
      ],
    );
  }
}

class ConsoleShiftModel {
  DateTime date;
  TimeOfDay start;
  TimeOfDay end;
  ConsoleShiftModel({this.date, this.start, this.end}) {
    date = DateTime.now();
    start = TimeOfDay.now();
    end = TimeOfDay.now();
  }
}

class InputData {
  final bool isMorningPerson;
  final bool likeMelatonin;
  final bool medicine;
  final String preferences;
  final DateTime departureDate;
  final DateTime dockDate;
  final DateTime undockDate;
  final TimeOfDay departureDeparture;
  final TimeOfDay dockingArrival;
  final TimeOfDay undockArrival;
  final TimeOfDay undockDeparture;
  final int location;
  final List<ConsoleShiftModel> shifts;
  InputData(
      this.isMorningPerson,
      this.likeMelatonin,
      this.medicine,
      this.preferences,
      this.departureDate,
      this.dockDate,
      this.undockDate,
      this.departureDeparture,
      this.dockingArrival,
      this.undockArrival,
      this.undockDeparture,
      this.location,
      this.shifts);
}
