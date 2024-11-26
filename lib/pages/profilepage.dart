import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  TextEditingController nameController = TextEditingController(text: 'John Doe');
  TextEditingController emailController = TextEditingController(text: 'johndoe@example.com');
  TextEditingController phoneController = TextEditingController(text: '+1234567890');
  TextEditingController addressController = TextEditingController(text: '123, Dummy Street, Dummy City, Dummy Country');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/dummy_profile_picture.png'),
              ),
            ),
            SizedBox(height: 20),
            isEditing
                ? TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  )
                : Text(
                    'Name: ${nameController.text}',
                    style: TextStyle(fontSize: 18),
                  ),
            SizedBox(height: 10),
            isEditing
                ? TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  )
                : Text(
                    'Email: ${emailController.text}',
                    style: TextStyle(fontSize: 18),
                  ),
            SizedBox(height: 10),
            isEditing
                ? TextField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                  )
                : Text(
                    'Phone: ${phoneController.text}',
                    style: TextStyle(fontSize: 18),
                  ),
            SizedBox(height: 10),
            isEditing
                ? TextField(
                    controller: addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                  )
                : Text(
                    'Address: ${addressController.text}',
                    style: TextStyle(fontSize: 18),
                  ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(isEditing ? 'Confirm' : 'Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}