import 'package:flutter/material.dart';

class PickLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Point of Departure',
              style: TextStyle(
                  fontSize: 10, fontFamily: 'Segoe-UI', color: Colors.grey)),
        ),
        Container(
            margin: new EdgeInsets.fromLTRB(10, 2, 10, 10),
            padding: new EdgeInsets.fromLTRB(5, 5, 5, 5),
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextField(
                style: TextStyle(fontSize: 12, fontFamily: 'Segoe-UI'),
                decoration: InputDecoration(
                    hintText: 'Location', border: InputBorder.none)))
      ],
    );
  }
}
