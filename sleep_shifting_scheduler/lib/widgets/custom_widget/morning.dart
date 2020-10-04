import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MorningButton extends StatelessWidget {
  MorningButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.white,
      splashColor: Colors.white,
      constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text(
              "Morning Person",
              maxLines: 1,
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
