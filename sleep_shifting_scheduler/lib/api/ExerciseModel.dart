class ExcerciseModel {
  // A Map with the date as the key and List of
  // Maps which each string is the exercise and int the duration in hours
  Map<DateTime, List<Map<String, int>>> exerciseMap;
  Map<String, List<Map<String, int>>> fromMap;
  ExcerciseModel({this.exerciseMap, this.fromMap}) {
    if (fromMap != null) {
      exerciseMap = fromMap.map(
        (String time, List<Map<String, int>> value) =>
            MapEntry(DateTime.parse(time), value),
      );
    }
  }

  Map<String, List<Map<String, int>>> toMap() => exerciseMap.map(
        (DateTime time, List<Map<String, int>> value) => MapEntry(
          time.toIso8601String().substring(0, 19),
          value,
        ),
      );
}
