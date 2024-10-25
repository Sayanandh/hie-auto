import 'package:flutter/material.dart';
import 'ride_nearby_page.dart'; // Import the RideNearbyPage
import 'activity_page.dart'; // Import the ActivityPage
import 'profile_page.dart'; // Import the ProfilePage

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Function to navigate to the RideNearbyPage
  void _navigateToRideNearby(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RideNearbyPage(),
      ),
    );
  }

  // Function to navigate to the ActivityPage
  void _navigateToActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ActivityPage(),
      ),
    );
  }

  // Function to navigate to the ProfilePage
  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(), // Ensure the ProfilePage constructor is correct
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Light grey background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome and search section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welcome Rinku',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Notification icon pressed
                    },
                    icon: const Icon(Icons.notifications_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search field (Navigates to RideNearbyPage when clicked)
              InkWell(
                onTap: () {
                  _navigateToRideNearby(context); // Navigate on tap
                },
                child: IgnorePointer( // This prevents the TextField from being interactive, treating it like a static widget
                  child: TextField(
                    readOnly: true, // Makes it read-only so tapping triggers navigation
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Where do you want to go?',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // "Your current location" label
              const Text(
                'Your current location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Placeholder for the map (to be replaced with map SDK)
              Container(
                height: 200, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Light grey to indicate map area
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Map goes here',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Recent rides section
              const Text(
                'Current Ride',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Ride details container (Example ride information)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Ride location image placeholder
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.location_on, size: 32, color: Colors.grey),
                    ),
                    const SizedBox(width: 16),

                    // Ride details text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Behind SCMS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Kadukuty',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Date & Time: 16 July 2024, 10:30 PM',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            'Driver: Auto Driver | Seats: 4',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            'Payment Status: Paid',
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 22, // Decrease the icon size
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                _navigateToActivity(context); // Navigate to activity page
              },
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {
                _navigateToProfile(context); // Navigate to profile page
              },
            ),
            label: 'Profile',
          ),
          // const BottomNavigationBarItem(
          //   icon: Icon(Icons.menu),
          //   label: 'More',
          // ),
        ],
      ),
    );
  }
}
