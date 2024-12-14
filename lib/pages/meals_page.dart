import 'package:flutter/material.dart';
import 'package:assignment2_flutter/services/api.dart';
import 'package:assignment2_flutter/models/meals.dart';

class MealsPage extends StatelessWidget {
  final String category;  // Now expecting a String (category name)

  const MealsPage({super.key, required this.category}); // Constructor expecting a category name

  // Fetch meals using the category
  Future<List<Meals>> fetchMeals(String category) async {
    return await Api().getMealsByCategory(category); // Fetch meals based on the category
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 151, 34, 25),
        title: Text(
          "$category Meals", // Display the category name in the title
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<List<Meals>>(
          future: fetchMeals(category), // Fetch meals based on the category
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(child: Text("No meals available"));
            }

            if (snapshot.hasData) {
              var meals = snapshot.data!;
              return ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Text(
                          meals[index].name!, // Display meal name
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 12),
                        Image.network(meals[index].imageUrl!),
                          const SizedBox(height: 12),
                      ],
                    ),
                  );
                },
              );
            }

            return const Center(child: Text("No meals available"));
          },
        ),
      ),
    );
  }
}
