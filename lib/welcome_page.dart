import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Use white background as in the design
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch, // Makes buttons stretch to fill the width
            children: [
              const Spacer(flex: 2), // Add space at the top

              // Top image (optional, you can adjust or remove)
              Image.asset(
                'assets/haiauto.png', // Replace with your image asset
                width: double.infinity,
                height: 200,
                //fit: BoxFit.cover, // Make the image cover the width
              ),

              const Spacer(flex: 1), // Add space between image and text

              // Main text
              const Text(
                "Let's get started",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign up or log in to find out the best Ride for you',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 1), // Add space between text and buttons

              // Sign up button
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Blue background as in the design
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12), // Space between buttons

              // Login with Google button
              ElevatedButton.icon(
                onPressed: () {
                  // Add Google login functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black12), // Border for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: Image.asset(
                  'assets/google_icon.png', // Google icon (replace with actual asset)
                  height: 24,
                  width: 24,
                ),
                label: const Text(
                  'Log In with Google',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12), // Space between buttons

              // Log in link at the bottom
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text(
                  "Already have an account? Log in",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent,
                  ),
                ),
              ),

              const Spacer(flex: 2), // Space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
