class MealModel {
  // Map of DateTime and ListOfMeals, breakfast lunch and diner
  Map<DateTime, List<Meal>> mealList;
  Map<String, List<Map<String, List<String>>>> fromMap;
  MealModel({this.mealList, this.fromMap}) {
    mealList = fromMap.map(
      (String date, List<Map<String, List<String>>> value) => MapEntry(
        DateTime.parse(date),
        value.map(
          (Map<String, List<String>> e) => Meal(fromMap: e),
        ),
      ),
    );
  }
  // Get today's meals
  List<Meal> getTodayMeals(DateTime day) =>
      mealList[DateTime(day.year, day.month, day.day)];
}

class Meal {
  // mealTitle the title of the meal A,B,C
  String mealTitle;
  // The list of food
  List<String> food;
  Map<String, List<String>> fromMap;
  Meal({this.mealTitle, this.food, this.fromMap}) {
    if (fromMap != null) {
      mealTitle = fromMap.keys.first;
      food = fromMap[mealTitle];
    }
  }
  String get title => mealTitle;
  List<String> get foodList => food;
  Map<String, List<String>> toMap() => {mealTitle: food};
}
