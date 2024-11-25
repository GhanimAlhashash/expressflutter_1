import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Page'),
      ),
      body: ListView(
        children: [
          _buildRecipeCard('Spaghetti Carbonara', 'A classic Italian pasta dish.', 'assets/spaghetti.jpg'),
          _buildRecipeCard('Chicken Curry', 'A spicy and flavorful dish.', 'assets/chicken_curry.jpg'),
          _buildRecipeCard('Beef Stroganoff', 'A rich and creamy beef dish.', 'assets/beef_stroganoff.jpg'),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(String title, String description, String imagePath) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Image.asset(imagePath),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
        ],
      ),
    );
  }
}