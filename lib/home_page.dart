import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ride_nearby_page.dart';
import 'activity_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// Navigates to the RideNearbyPage
  void _navigateToRideNearby(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RideNearbyPage(),
      ),
    );
  }

  /// Navigates to the ActivityPage
  void _navigateToActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ActivityPage(),
      ),
    );
  }

  /// Navigates to the ProfilePage
  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  /// Fetch user's name from Firestore
  Future<String?> _fetchUserName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users') // Replace with your Firestore collection name
            .doc(user.uid)
            .get();

        return docSnapshot.data()?['name'] ?? "Guest";
      }
      return "Guest";
    } catch (e) {
      debugPrint('Error fetching user name: $e');
      return "Guest";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome and Notification Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String?>(
                    future: _fetchUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          'Loading...',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Text(
                          'Error loading user',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        );
                      }
                      return Text(
                        'Welcome, ${snapshot.data ?? "Guest"}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      // Add notification functionality here if needed
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search Field (Redirects to RideNearbyPage on tap)
              InkWell(
                onTap: () => _navigateToRideNearby(context),
                child: IgnorePointer(
                  child: TextField(
                    readOnly: true,
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

              // Current location label
              const Text(
                'Your Current Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Map Placeholder
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Map Placeholder',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Current Ride',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Example current ride details card
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
                  children: const [
                    Icon(Icons.location_on, size: 32, color: Colors.grey),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Behind SCMS',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Kadukuty',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Driver: Auto Driver | Seats: 4',
                          ),
                          Text(
                            'Payment Status: Paid',
                            style: TextStyle(color: Colors.green),
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

      /// Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 22,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.history),
              onPressed: () => _navigateToActivity(context),
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () => _navigateToProfile(context),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
