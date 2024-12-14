class Categories {
  int? id;
  String? name;
  String? imageUrl;
  String? description;

  Categories({this.id, this.name, this.imageUrl, this.description});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json["idCategory"] != null ? int.tryParse(json["idCategory"].toString()) : null,
      name: json["strCategory"],
      imageUrl: json["strCategoryThumb"],
      description: json["strCategoryDescription"],
    );
  }
}
