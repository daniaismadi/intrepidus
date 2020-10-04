import 'package:flutter/material.dart';

class PickLocation extends StatefulWidget {
  final Function setLocation;
  PickLocation(this.setLocation);
  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  String dropdownValue = 'Kennedy Space Center, US';
  List<int> timezone = [-5, 8, 9, 2];
  List<String> locations = [
    'Kennedy Space Center, US',
    'Wenchang Satellite Launch Center, CHI',
    'Tanegashima Space Center, JPN',
    'Salto di Quirra, ITL'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Point of Departure',
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Segoe-UI',
              color: Colors.grey,
            ),
          ),
        ),
        Container(
            margin: new EdgeInsets.fromLTRB(10, 2, 10, 10),
            padding: new EdgeInsets.fromLTRB(5, 5, 5, 5),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              onChanged: (String newValue) {
                setState(() {
                  widget.setLocation(
                      locations.indexWhere((element) => element == newValue));
                  dropdownValue = newValue;
                });
              },
              items: locations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 10),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }
}
