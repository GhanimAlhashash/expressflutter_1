import 'package:flutter/material.dart';

class AddRecipeForm extends StatefulWidget {
  @override
  _AddRecipeFormState createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  final _formKey = GlobalKey<FormState>();
  String _recipeName = '';
  String _description = '';
  String _selectedCategory = '';
  String _selectedIngredient = '';
  List<String> _categories = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  List<String> _ingredients = ['Eggs', 'Milk', 'Flour', 'Sugar'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Recipe'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Recipe Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recipe name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _recipeName = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value ?? '';
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Category'),
                value: _selectedCategory.isNotEmpty ? _selectedCategory : null,
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value as String;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Ingredient'),
                value: _selectedIngredient.isNotEmpty ? _selectedIngredient : null,
                items: _ingredients.map((ingredient) {
                  return DropdownMenuItem(
                    value: ingredient,
                    child: Text(ingredient),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedIngredient = value as String;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an ingredient';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Process data
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}