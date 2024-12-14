import 'package:assignment2_flutter/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:assignment2_flutter/models/categories.dart';
import 'package:assignment2_flutter/services/api.dart';
import 'package:assignment2_flutter/pages/meals_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  Future<List<Categories>> fetchCategories() async {
    await Api().getData(); // Wait for data to be fetched
    return allCategories; // Return the list of categories
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 151, 34, 25),
        title: const Text(
          "Categories",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<Categories>>(
          future: fetchCategories(), // Future for fetching data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(child: Text("No categories available"));
            }

            if (snapshot.hasData) {
              var categories = snapshot.data!;

              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Use Navigator.push() instead of context.push()
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealsPage(category: categories[index].name!),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 255, 215, 175),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                ("(${categories[index].id})"),
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 151, 34, 25)),
                              ),
                              Text(
                                categories[index].name.toString(),
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 151, 34, 25)),
                              ),
                            ],
                          ),
                          Image.network(
                                  categories[index].imageUrl.toString()),
                                    const SizedBox(height: 15),
                          const SizedBox(height: 12),
                          Text(categories[index].description!),
                        ],
                      ),
                    ),

                  );
                },
              );
            }

            return const Center(child: Text("No categories available"));
          },
        ),
      ),
    );
  }
}
