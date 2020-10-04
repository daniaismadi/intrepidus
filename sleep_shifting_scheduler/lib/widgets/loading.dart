import 'package:flutter/material.dart';
import 'calendar.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPage createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3), () => true),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return Scaffold(
          body: Center(
            child: !snapshot.hasData
                ? CircularProgressIndicator()
                : CalenderWidget(),
          ),
        );
      },
    );
  }
}
