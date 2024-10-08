import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  void home(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void profile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activity',
          style: TextStyle(
            fontFamily: 'CustomFont', // Custom font for AppBar title
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ride History and Booking Details',
              style: TextStyle(
                fontFamily: 'CustomFont', // Custom font for main text
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => home(context),
              child: const Text(
                'Back to Home',
                style: TextStyle(
                  fontFamily: 'CustomFont', // Custom font for button text
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => profile(context),
              child: const Text(
                'Go to Profile',
                style: TextStyle(
                  fontFamily: 'CustomFont', // Custom font for button text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
