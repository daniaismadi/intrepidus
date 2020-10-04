import 'package:flutter/material.dart';

class PickTimeWidget extends StatefulWidget {
  final String timeType;
  final Function pickTime;
  PickTimeWidget({Key key, @required this.timeType, this.pickTime})
      : super(key: key);

  @override
  _PickTimeWidgetState createState() => _PickTimeWidgetState();
}

class _PickTimeWidgetState extends State<PickTimeWidget> {
  TimeOfDay time = new TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(widget.timeType,
              style: TextStyle(
                  fontSize: 10, fontFamily: 'Segoe-UI', color: Colors.grey)),
        ),
        GestureDetector(
            onTap: () {
              _selectTime(context);
            },
            child: Container(
                margin: new EdgeInsets.fromLTRB(10, 2, 10, 10),
                padding: new EdgeInsets.fromLTRB(10, 7, 10, 7),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text(
                    "${time.toString().substring(10, 15)}".split(' ')[0],
                    style: TextStyle(fontSize: 12, fontFamily: 'Segoe-UI')))),
      ],
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePicker(
        context: context,
        initialTime: time,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child);
        });

    if (timePicked != null) {
      setState(() => time = timePicked);
      widget.pickTime(timePicked);
    }
  }
}
