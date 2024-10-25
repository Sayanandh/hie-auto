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
          'Popular Car',
          style: TextStyle(
            fontFamily: 'CustomFont', // Custom font for AppBar title
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Sorting functionality (for now just a placeholder)
              print('Sort Ascending/Descending');
            },
            child: const Text(
              'Ascending',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'CustomFont',
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          RideCard(
            pickUp: '1901 Thornridge Cir. Shiloh',
            dropOff: '4140 Parker Rd. Allentown',
            dateTime: '16 July 2023, 10:30 PM',
            driverName: 'Jane Cooper',
            carSeats: 4,
            paymentStatus: 'Paid',
          ),
          const SizedBox(height: 10),
          RideCard(
            pickUp: '1901 Thornridge Cir. Shiloh',
            dropOff: '4140 Parker Rd. Allentown',
            dateTime: '16 July 2023, 10:30 PM',
            driverName: 'Jane Cooper',
            carSeats: 4,
            paymentStatus: 'Paid',
          ),
          // Add more RideCard widgets as needed
        ],
      ),
    );
  }
}

class RideCard extends StatelessWidget {
  final String pickUp;
  final String dropOff;
  final String dateTime;
  final String driverName;
  final int carSeats;
  final String paymentStatus;

  const RideCard({
    Key? key,
    required this.pickUp,
    required this.dropOff,
    required this.dateTime,
    required this.driverName,
    required this.carSeats,
    required this.paymentStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Placeholder for map or location image
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey.shade300, // Placeholder for the image
                  child: const Icon(Icons.map),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pickUp,
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      dropOff,
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date & Time',
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      dateTime,
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Driver',
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      driverName,
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.event_seat),
                    const SizedBox(width: 5),
                    Text(
                      '$carSeats seats',
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  paymentStatus,
                  style: TextStyle(
                    fontFamily: 'CustomFont',
                    fontSize: 14,
                    color: paymentStatus == 'Paid' ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Activity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ActivityPage(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          child: const Text('Go to Activity'),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          child: const Text('Go to Activity'),
        ),
      ),
    );
  }
}
