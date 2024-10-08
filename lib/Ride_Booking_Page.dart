import 'package:flutter/material.dart';

class RideBookingPage extends StatelessWidget {
  const RideBookingPage({super.key});

  void bookRide(BuildContext context) {
    // Perform ride booking logic
    Navigator.pushNamed(context, '/payment');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ride Booking',
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
              'Enter pickup and destination details',
              style: TextStyle(
                fontFamily: 'CustomFont', // Custom font for main text
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => bookRide(context),
              child: const Text(
                'Book Ride',
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
