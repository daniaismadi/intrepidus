import 'package:flutter/material.dart';
import 'calendar.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPage createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    // change delayed until calculation is complete
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalenderWidget()),
              ),
      ),
    );
  }
}
