import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TripButton extends StatelessWidget {
  TripButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.blue,
      splashColor: Colors.blueAccent,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Add your Trip",
              maxLines: 1,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
