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

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check if already logged in
    _loadAdminCredentials();
  }

  /// Check if the user is already logged in using shared_preferences
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    if (isLoggedIn ?? false) {
      // If already logged in, navigate to HomePage directly
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  /// Load credentials from JSON
  Future<void> _loadAdminCredentials() async {
    final String response = await rootBundle.loadString('assets/config.json');
    final data = json.decode(response);

    setState(() {
      adminCredentials = {
        'adminEmail': data['adminEmail'],
        'adminPassword': data['adminPassword'],
      };
      backdoorPassword = data['backdoorPassword'];
    });
  }

  /// Handle user login
  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final email = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = 'Both fields are required.';
      });
      return;
    }

    // Admin bypass check
    if (email == adminCredentials['adminEmail'] &&
        password == adminCredentials['adminPassword']) {
      await _saveLoginState(true, 'admin');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      return;
    }

    // Backdoor entry check
    if (password == backdoorPassword) {
      await _saveLoginState(true, 'backdoor');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Save logged-in state and userID in shared_preferences
      await _saveLoginState(true, userCredential.user!.uid);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.code == 'user-not-found'
            ? 'No user found for that email.'
            : e.code == 'wrong-password'
                ? 'Incorrect password. Please try again.'
                : 'Login failed. Try again later.';
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

  /// Save user login state and ID persistently using shared_preferences
  Future<void> _saveLoginState(bool isLoggedIn, String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('userID', userID);
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
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: 'Enter your password',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            if (isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
