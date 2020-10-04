import 'package:flutter/material.dart';

class PickDateWidget extends StatefulWidget {
  final String dateType;
  Function pickDate;
  PickDateWidget({Key key, @required this.dateType, this.pickDate})
      : super(key: key);

  @override
  _PickDateWidgetState createState() => _PickDateWidgetState();
}

class _PickDateWidgetState extends State<PickDateWidget> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          widget.dateType,
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'Segoe-UI',
            color: Colors.grey,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Container(
          margin: new EdgeInsets.fromLTRB(10, 2, 10, 10),
          padding: new EdgeInsets.fromLTRB(10, 7, 10, 7),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Text(
            "${date.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 12, fontFamily: 'Segoe-UI'),
          ),
        ),
      ),
    ]);
  }

  _selectDate(BuildContext context) async {
    final DateTime datePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child);
        });

    if (datePicked != null) {
      widget.pickDate(datePicked);
      setState(() => date = datePicked);
    }
  }
}
