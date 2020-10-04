import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
    this.activeColor,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;
  final Color activeColor;

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            CupertinoSwitch(
              value: value,
              activeColor: activeColor,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
