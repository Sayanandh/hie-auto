import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Your Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white, // Set background color to white
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder image
                ),
              ),
              const SizedBox(height: 20),

              // First Name
              _buildProfileField(context, 'First name', 'Marin'),
              const SizedBox(height: 16),

              // Last Name
              _buildProfileField(context, 'Last name', 'JS Mastery'),
              const SizedBox(height: 16),

              // Email
              _buildProfileField(context, 'Email', 'marin@jsmastery.pro', isEmail: true),
              const SizedBox(height: 8),

              // Email status
              const Text(
                'Email status:',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const Text(
                'Verified',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),

              // Phone Number
              _buildProfileField(context, 'Phone number', '+5547824162'),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.black),
                onPressed: () {
                  // Navigate to Home
                },
              ),
              IconButton(
                icon: const Icon(Icons.message, color: Colors.black),
                onPressed: () {
                  // Navigate to Messages
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Perform the save action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.black),
                onPressed: () {
                  // Navigate to Profile
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(BuildContext context, String label, String value, {bool isEmail = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            SizedBox(
              width: 250, // Set a width to control the field's size
              child: TextField(
                enabled: false, // Set to false to make it non-editable
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: value,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
            ),
          ],
        ),
        const Icon(Icons.edit, color: Colors.grey), // Edit icon
      ],
    );
  }
}
