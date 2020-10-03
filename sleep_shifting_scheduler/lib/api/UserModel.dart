class UserModel {
  // Variables are public
  String id;
  String name;
  Map<String, List<Map<String, dynamic>>> event;
  Map<String, dynamic> fromMap;
  UserModel({this.id, this.name, this.event, this.fromMap}) {
    if (fromMap != null) {
      id = fromMap['id'];
      name = fromMap['name'];
      event = fromMap['event'];
    }
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'event': event,
      };
}
