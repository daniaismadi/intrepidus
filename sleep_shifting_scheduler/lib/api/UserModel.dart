class UserModel {
  // Variables are public
  String id;
  String name;
  Map<String, List<Map<String, dynamic>>> event;
  Map<String, List<Map<String, int>>> exercise;
  Map<String, Map<String, List<String>>> meal;
  Map<String, dynamic> fromMap;
  UserModel(
      {this.id,
      this.name,
      this.event,
      this.exercise,
      this.meal,
      this.fromMap}) {
    if (fromMap != null) {
      id = fromMap['id'];
      name = fromMap['name'];
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
