import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'login.dart';
import 'signup.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'activity_page.dart';
import 'ride_booking_page.dart';
import 'payment_page.dart';
import 'welcome_page.dart';
import 'introduction_pages.dart';
import 'ride_nearby_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final logger = Logger();

  try {
    // Check if onboarding is complete
    final prefs = await SharedPreferences.getInstance();
    final bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
    runApp(MyApp(onboardingComplete: onboardingComplete));
  } catch (e) {
    logger.e('Error initializing app: $e');
    runApp(const MyApp(onboardingComplete: false));
  }
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
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/activity': (context) => const ActivityPage(),
        '/rideBooking': (context) => const RideBookingPage(),
        '/payment': (context) => const PaymentPage(),
        '/rideNearby': (context) => const RideNearbyPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
