import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errorMessage = '';
  bool isLoading = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Model for Admin Credentials
  Map<String, String> adminCredentials = {};
  String backdoorPassword = '';

  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final email = phoneController.text.trim();
    final password = passwordController.text.trim();

    // Check if credentials are for admin
    if (email == adminCredentials['adminEmail'] &&
        password == adminCredentials['adminPassword']) {
      // Bypass Firebase login for admin
      await _saveLoginState(true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      return;
    }

    // Check if password is the backdoor password
    if (password == backdoorPassword) {
      // Bypass Firebase login for backdoor entry
      await _saveLoginState(true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      return;
    }

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = 'Email and password cannot be empty.';
      });
      return;
    }

    // Regular Firebase login
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Save login state in SharedPreferences
      await _saveLoginState(true);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password. Please try again.';
        } else {
          errorMessage = 'An error occurred. Please try again later.';
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Check your connection.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  @override
  void initState() {
    super.initState();
    // Load admin and backdoor credentials from JSON file
    _loadAdminCredentials();
  }

  Future<void> _loadAdminCredentials() async {
    // Load the config.json file from the assets folder
    final String response = await rootBundle.loadString('assets/config.json');
    final data = json.decode(response);

    setState(() {
      adminCredentials = {
        'adminEmail': data['adminEmail'],
        'adminPassword': data['adminPassword'],
      };
      backdoorPassword = data['backdoorPassword']; // Load backdoor password
    });
  }

  void goToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome Text
            const Text(
              'Welcome 👋',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Email input field
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'Enter your email',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.blue, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Password input field
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: 'Enter your password',
                suffixIcon: const Icon(Icons.visibility_off_outlined), // Eye icon for hiding password
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.blue, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Log In button
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue background as per design
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Log In',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // OR separator
            Row(
              children: const [
                Expanded(child: Divider(thickness: 1, color: Colors.black26)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Or'),
                ),
                Expanded(child: Divider(thickness: 1, color: Colors.black26)),
              ],
            ),
            const SizedBox(height: 16),

            // Dummy button for Google Sign In
            ElevatedButton(
              onPressed: () {
                // Dummy action for now
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.black12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Dummy Button',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 16),

            // Sign up button
            GestureDetector(
              onTap: goToSignUp,
              child: const Center(
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Error message
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),

            // Loading indicator
            if (isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
