import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:restcountries/restcountries.dart';

// main() async {
//   // Get countries.
//   var api = RestCountries.setup("b9eb0ba3366c890ff9ff22cac707b217");
//   List<Country> countries = await api.getCountries();
// }

class DockingWidget extends StatefulWidget {
  DockingWidget({Key key}) : super(key: key);

  @override
  _DockingWidgetState createState() => _DockingWidgetState();
}

class _DockingWidgetState extends State<DockingWidget> {
  DateTime departureDate = new DateTime.now();
  TimeOfDay departureTime = new TimeOfDay.now();
  DateTime dockingDate = new DateTime.now();
  TimeOfDay arrivalTime = new TimeOfDay.now();
  DateTime undockingDate = new DateTime.now();
  TimeOfDay undockDeparture = new TimeOfDay.now();
  TimeOfDay undockArrival = new TimeOfDay.now();
  String location = 'Location';
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('When are you docking and undocking?',
                        style: TextStyle(fontSize: 20, fontFamily: 'Segoe'),
                        textAlign: TextAlign.center),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      dateContainer('Departure Date'),
                      timeContainer('Departure')
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      dateContainer('Docking Date'),
                      timeContainer('Arrival')
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      dateContainer('Undocking Date'),
                      timeContainer('Departure'),
                      timeContainer('Arrival')
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [locationContainer()],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('lib/images/intrepiduslogorescale.svg')
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.arrow_left),
                  RaisedButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      color: Colors.blueAccent,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text('Confirm',
                              style: TextStyle(
                                  fontFamily: 'Segoe', fontSize: 15))))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget locationContainer() {
    return Column(children: [
      Text('Point of Departure',
          style:
              TextStyle(fontSize: 12, fontFamily: 'Segoe', color: Colors.grey),
          textAlign: TextAlign.left),
      pickLocation()
    ]);
  }

  Widget dateContainer(String label) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(label,
          style:
              TextStyle(fontSize: 12, fontFamily: 'Segoe', color: Colors.grey)),
      pickDate()
    ]);
  }

  Widget timeContainer(String label) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(label,
          style:
              TextStyle(fontSize: 12, fontFamily: 'Segoe', color: Colors.grey)),
      pickTime()
    ]);
  }

  _showDialog() async {
    await showDialog<String>(
        context: context,
        child: new _SystemPadding(
            child: new AlertDialog(
          contentPadding: const EdgeInsets.all(15),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Point of Departure',
                        hintText: 'eg. Kuala Lumpur'),
                    controller: myController),
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('SET'),
                onPressed: () {
                  if (myController.text != null) {
                    setState(() {
                      location = myController.text;
                    });
                    Navigator.pop(context);
                  }
                })
          ],
        )));
  }

  Widget pickLocation() {
    return GestureDetector(
      onTap: () => _showDialog(),
      child: Container(
          margin: new EdgeInsets.fromLTRB(10, 2, 10, 10),
          padding: new EdgeInsets.fromLTRB(5, 10, 200, 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Text("${location.toString()}",
              style: TextStyle(fontSize: 12, fontFamily: 'Segoe'))),
    );
  }

  Widget pickDate() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
          margin: new EdgeInsets.fromLTRB(10, 2, 10, 10),
          padding: new EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Text("${departureDate.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: 12, fontFamily: 'Segoe'))),
    );
  }

  Widget pickTime() {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
          margin: new EdgeInsets.fromLTRB(10, 2, 10, 10),
          padding: new EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Text("${departureTime.toString().substring(10, 15)}",
              style: TextStyle(fontSize: 12, fontFamily: 'Segoe'))),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: departureTime,
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });

    if (time != null) {
      setState(() {
        departureTime = time;
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: departureDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });
    if (picked != null && picked != departureDate) {
      setState(() {
        departureDate = picked;
      });
    }
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(child: child);
  }
}
