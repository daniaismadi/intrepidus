import 'package:sleep_shifting_scheduler/api/UserModel.dart';

String timeZone = '+6';
// Trial user.
UserModel exampleUser = UserModel(fromMap: {
  'id': '1',
  'morning': true,
  'melatonin': true,
  'name': 'Buzz Lightyear',
  'event': {},
  'exercise': {},
  'meal': {}
});

generateSleepSchedule(UserModel user) {
  bool morning = true;
  bool melatonin = true;

  // Parse int
  int offset = int.parse(timeZone[1]);
  int initialHour;
  int daysTillOptimal;

  // Find initial sleep time.
  if (morning) {
    initialHour = (22 + offset) % 24;
    daysTillOptimal = 22 - initialHour;
  }

  for (int i = 0; i <= daysTillOptimal; i++) {}
}
