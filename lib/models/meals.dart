class Meals {
  final String? name;
  final String? imageUrl;

  Meals({this.name, this.imageUrl});

  factory Meals.fromJson(Map<String, dynamic> json) {
    return Meals(
      name: json["strMeal"],
      imageUrl: json["strMealThumb"],
    );
  }
}
