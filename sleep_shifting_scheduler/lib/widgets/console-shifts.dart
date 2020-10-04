import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickDate.dart';
import 'package:sleep_shifting_scheduler/widgets/custom_widget/pickTime.dart';

class ConsoleWidget extends StatefulWidget {
  @override
  _ConsoleWidgetState createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  int numShifts = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: new EdgeInsets.fromLTRB(0, 0, 0, 30),
            height: MediaQuery.of(context).size.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                      child: Container(
                          margin: new EdgeInsets.fromLTRB(40, 100, 40, 10),
                          padding: new EdgeInsets.fromLTRB(5, 20, 5, 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(7, 78, 232, 1.0),
                                  width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          alignment: Alignment(0, 0),
                          width: 280,
                          height: 400,
                          child: buildFields())),
                  // Bottom widgets.
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                  'lib/images/intrepiduslogo180px.svg',
                                  width: 90,
                                  height: 90)
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
                                            fontFamily: 'Segoe-UI',
                                            fontSize: 15))))
                          ],
                        ),
                      )
                    ],
                  )
                ])));
  }

  Widget buildFields() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'List your console shifts',
              style: TextStyle(fontSize: 20, fontFamily: 'Segoe-UI'),
              textAlign: TextAlign.left,
            )),
        Expanded(
          child: ListView.builder(
              itemCount: numShifts,
              itemBuilder: (BuildContext context, int index) {
                return buildDateTimeInput();
              }),
        ),
        OutlineButton(
          child: new Text('+ Add date and time',
              style: TextStyle(
                  color: Color.fromRGBO(7, 78, 232, 1.0),
                  fontFamily: 'Segoe-UI',
                  fontSize: 12)),
          shape: new RoundedRectangleBorder(
              side:
                  BorderSide(color: Color.fromRGBO(7, 78, 232, 1.0), width: 2),
              borderRadius: new BorderRadius.circular(10)),
          borderSide:
              BorderSide(color: Color.fromRGBO(7, 78, 232, 1.0), width: 1),
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
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      new PickDateWidget(dateType: 'Date'),
      new PickTimeWidget(timeType: 'Time'),
      new PickTimeWidget(timeType: 'Time')
    ]);
  }
}
