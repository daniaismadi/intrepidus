class UserModel {
  // Variables are public
  String id;
  String name;
  bool morning;
  bool melatonin;
  dynamic event;
  dynamic exercise;
  dynamic meal;
  Map<String, dynamic> fromMap;

  UserModel(
      {this.id,
      this.name,
      this.morning,
      this.melatonin,
      this.event,
      this.exercise,
      this.meal,
      this.fromMap}) {
    if (fromMap != null) {
      id = fromMap['id'];
      name = fromMap['name'];
      morning = fromMap['morning'];
      melatonin = fromMap['melatonin'];
      event = fromMap['event'];
      exercise = fromMap['exercise'];
      meal = fromMap['meal'];
    }
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'event': event,
        'exercise': exercise,
        'meal': meal,
      };
}
