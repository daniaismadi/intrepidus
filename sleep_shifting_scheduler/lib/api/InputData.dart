import 'package:flutter/material.dart';

class ConsoleShiftModel {
  // The day that the user will be planning their shifts
  DateTime date;
  TimeOfDay start;
  TimeOfDay end;
  ConsoleShiftModel({this.date, this.start, this.end}) {
    date = DateTime.now();
    start = TimeOfDay.now();
    end = TimeOfDay.now();
  }
}

class InputData {
  // The data from the user Input
  final bool isMorningPerson;
  final bool likeMelatonin;
  final bool medicine;
  final String preferences;
  final DateTime departureDate;
  final DateTime dockDate;
  final DateTime undockDate;
  final TimeOfDay departureDeparture;
  final TimeOfDay dockingArrival;
  final TimeOfDay undockArrival;
  final TimeOfDay undockDeparture;
  final int location;
  final List<ConsoleShiftModel> shifts;
  InputData(
    this.isMorningPerson,
    this.likeMelatonin,
    this.medicine,
    this.preferences,
    this.departureDate,
    this.dockDate,
    this.undockDate,
    this.departureDeparture,
    this.dockingArrival,
    this.undockArrival,
    this.undockDeparture,
    this.location,
    this.shifts,
  );
}
