import 'package:assignment2_flutter/data/global_data.dart';
import 'package:assignment2_flutter/models/categories.dart';
import 'package:assignment2_flutter/models/meals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  final String categoriesUrl = "https://www.themealdb.com/api/json/v1/1/categories.php";
  final String mealsUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c=";

  // Existing getData() method
  Future<void> getData() async {
    var uri = Uri.parse(categoriesUrl);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (var element in responseJson["categories"]) {
        allCategories.add(Categories.fromJson(element));
      }
    } else {
      print('Error fetching categories');
    }
  }

  // Fetch meals based on category
  Future<List<Meals>> getMealsByCategory(String category) async {
    var uri = Uri.parse(mealsUrl + category);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      List<Meals> meals = [];
      for (var element in responseJson["meals"]) {
        meals.add(Meals.fromJson(element));
      }
      return meals;
    } else {
      print('Error fetching meals for category: $category');
      return [];
    }
  }
}