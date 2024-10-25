import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // App bar background color set to white
        elevation: 0, // Remove shadow from the app bar
        title: const Text(
          'Your Profile',
          style: TextStyle(
            color: Colors.black, // Set title text color to black
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the icon color to black
        ),
      ),
      body: Container(
        color: Colors.white, // Set the entire background to white
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Placeholder image
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
              const SizedBox(height: 16),

              // Email status
              const Text(
                'Email status',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Icon(Icons.verified, color: Colors.green),
                  SizedBox(width: 5),
                  Text(
                    'Verified',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Phone Number
              _buildProfileField(context, 'Phone number', '+5547824162'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(BuildContext context, String label, String value, {bool isEmail = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.grey),
            onPressed: () {
              // Edit action
            },
          ),
        ],
      ),
    );
  }
}
