import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickDate.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickTime.dart';
import 'package:sleep_shifting_scheduler/widgets/dock-undock.dart';
import 'loading.dart';

class ConsoleWidget extends StatefulWidget {
  @override
  _ConsoleWidgetState createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  int numShifts = 4;

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadingPage()),
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
            itemCount: numShifts,
            itemBuilder: (BuildContext context, int index) {
              return buildDateTimeInput();
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
            setState(() {
              numShifts += 1;
            });
          },
        )
      ],
    );
  }

  Widget buildDateTimeInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new PickDateWidget(dateType: 'Date'),
        new PickTimeWidget(timeType: 'Time'),
        new PickTimeWidget(timeType: 'Time')
      ],
    );
  }
}
