import 'package:assignment2_flutter/pages/categories_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 32),
          Image.asset("assets/image.png"),
          const Text(
            "Welcome to FoodRec!\n Find all the recpeies you need",
            style: TextStyle(
                color: Color.fromARGB(255, 231, 120, 35), fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, 
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CategoriesPage()));
            },
            child: const Text(
              "Start",
              style: TextStyle(color: Color.fromARGB(255, 151, 34, 25)),
            ),
          )
        ],
      )),
    );
  }
}
