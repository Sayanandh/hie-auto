import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart' as login;
import 'signup.dart' as signup;
import 'home_page.dart';
import 'profile_page.dart';
import 'activity_page.dart';
import 'ride_booking_page.dart';
import 'payment_page.dart';
import 'welcome_page.dart';
import 'introduction_pages.dart';
import 'ride_nearby_page.dart'; // Import the RideNearbyPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Check if onboarding is complete
  final prefs = await SharedPreferences.getInstance();
  final bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

  runApp(MyApp(onboardingComplete: onboardingComplete));
}

class MyApp extends StatelessWidget {
  final bool onboardingComplete;

  const MyApp({super.key, required this.onboardingComplete});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hai Auto',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'CustomFont', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'CustomFont', fontSize: 14),
          displayLarge: TextStyle(fontFamily: 'CustomFont', fontSize: 96),
          displayMedium: TextStyle(fontFamily: 'CustomFont', fontSize: 60),
          displaySmall: TextStyle(fontFamily: 'CustomFont', fontSize: 48),
          headlineLarge: TextStyle(fontFamily: 'CustomFont', fontSize: 34),
          headlineMedium: TextStyle(fontFamily: 'CustomFont', fontSize: 24),
          headlineSmall: TextStyle(fontFamily: 'CustomFont', fontSize: 20),
          titleMedium: TextStyle(fontFamily: 'CustomFont', fontSize: 16),
          titleSmall: TextStyle(fontFamily: 'CustomFont', fontSize: 14),
          labelLarge: TextStyle(fontFamily: 'CustomFont', fontSize: 14),
        ),
      ),
      initialRoute: onboardingComplete ? '/welcome' : '/introduction',
      routes: {
        '/introduction': (context) => const IntroductionPages(),
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const login.LoginPage(),
        '/signup': (context) => const signup.SignupPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/activity': (context) => const ActivityPage(),
        '/rideBooking': (context) => const RideBookingPage(),
        '/payment': (context) => const PaymentPage(),
        '/rideNearby': (context) => const RideNearbyPage(), // Added route for RideNearbyPage
      },
    );
  }
}
