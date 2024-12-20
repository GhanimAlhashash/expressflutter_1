import 'package:expressflutter_1/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecipeForm extends StatefulWidget {
  @override
  _AddRecipeFormState createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  final _formKey = GlobalKey<FormState>();
  String _recipeName = '';
  String _description = '';
  String _selectedCategory = '';
  List<String> _selectedIngredients = [];
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
              FutureBuilder(
              future: Provider.of<CategoryProvider>(context, listen: false).getCategories(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapshot.error != null) {
                    return const Center(
                      child: Text('An error occurred'),
                    );
                  } else {
                    return Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, child) {
                        final categories = categoryProvider.categories;

                        if (categories.isEmpty) {
                          return const Center(
                            child: Text('No categories found'),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              value: _selectedCategory == '' ? categories[0].name : _selectedCategory,
                              isExpanded: true,
                              items: categories.map<DropdownMenuItem<String>>((category) {
                                return DropdownMenuItem<String>(
                                  value: category.name,
                                  child: Text(category.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                print(value);
                                _selectedCategory = value!;
                                setState(() {
                                  
                                });
                              },
                            ),
                          );
                        }
                      },
                    );
                  }
                }
              },
            ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Recipe Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
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
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                maxLines: 5, // Set maxLines to a higher value for a description box
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
              SizedBox(height: 20),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Ingredients',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      children: _selectedIngredients.map((ingredient) {
                        return Chip(
                          label: Text(ingredient),
                          onDeleted: () {
                            setState(() {
                              _selectedIngredients.remove(ingredient);
                            });
                          },
                        );
                      }).toList(),
                    ),
                    TextButton(
                      onPressed: () async {
                        final List<String>? selected = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MultiSelectDialog(
                              items: _ingredients,
                              initialSelectedItems: _selectedIngredients,
                            );
                          },
                        );
                        if (selected != null) {
                          setState(() {
                            _selectedIngredients = selected;
                          });
                        }
                      },
                      child: Text('Select Ingredients'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    
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

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> initialSelectedItems;

  MultiSelectDialog({required this.items, required this.initialSelectedItems});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.initialSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Ingredients'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: _selectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? checked) {
                setState(() {
                  if (checked == true) {
                    _selectedItems.add(item);
                  } else {
                    _selectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, _selectedItems);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}