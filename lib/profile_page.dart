import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'CustomFont', // Use custom font
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder image
            ),
            const SizedBox(height: 20),
            
            // Personal Details in a Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: John Doe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CustomFont', // Use custom font
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Phone: +123 456 7890',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CustomFont', // Use custom font
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email: johndoe@email.com',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CustomFont', // Use custom font
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Address: 123 Main St, City, Country',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'CustomFont', // Use custom font
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Recent Ride Activity
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Rides',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont', // Use custom font
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                ListTile(
                  leading: Icon(Icons.directions_bus, color: Colors.black), // Using a bus icon for rickshaws
                  title: Text(
                    'Ride to Downtown',
                    style: TextStyle(
                      fontFamily: 'CustomFont', // Use custom font
                    ),
                  ),
                  subtitle: Text(
                    'Date: Sep 15, 2024 - Fare: \$20',
                    style: TextStyle(
                      fontFamily: 'CustomFont', // Use custom font
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.directions_bus, color: Colors.black),
                  title: Text(
                    'Ride to Airport',
                    style: TextStyle(
                      fontFamily: 'CustomFont', // Use custom font
                    ),
                  ),
                  subtitle: Text(
                    'Date: Sep 10, 2024 - Fare: \$35',
                    style: TextStyle(
                      fontFamily: 'CustomFont', // Use custom font
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.directions_bus, color: Colors.black),
                  title: Text(
                    'Ride to Mall',
                    style: TextStyle(
                      fontFamily: 'CustomFont', // Use custom font
                    ),
                  ),
                  subtitle: Text(
                    'Date: Sep 05, 2024 - Fare: \$12',
                    style: TextStyle(
                      fontFamily: 'CustomFont', // Use custom font
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),

            // Back to Home Button
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Back to Home',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CustomFont', // Use custom font
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
