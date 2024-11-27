import 'package:flutter/material.dart';

class DropBox extends StatefulWidget {
  @override
  _DropBoxState createState() => _DropBoxState();
}

class _DropBoxState extends State<DropBox> {
  String? _selectedItem;
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchDataFromBackend();
  }

  Future<void> _fetchDataFromBackend() async {
    // Simulate fetching data from backend
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _items = ['Item 1', 'Item 2', 'Item 3']; // Replace with actual data from backend
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Select an item'),
      value: _selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          _selectedItem = newValue;
        });
      },
      items: _items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}