import 'package:flutter/material.dart';

class RideNearbyPage extends StatelessWidget {
  const RideNearbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Light grey background
      appBar: AppBar(
        title: const Text('Ride'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {
              // Handle filter action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            // Map placeholder area
            Container(
              height: 300, // Placeholder height for the map
              decoration: BoxDecoration(
                color: Colors.grey[300], // Light grey to indicate map area
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Map with nearby rides goes here',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Search inputs for "From" and "To"
            Column(
              children: [
                // "From" location field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'From location',
                    prefixIcon: const Icon(Icons.location_on),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // "To" location field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'To location',
                    prefixIcon: const Icon(Icons.flag),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // "Find Now" button
            ElevatedButton(
              onPressed: () {
                // Handle the ride search functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Find Now',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
