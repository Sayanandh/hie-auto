import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class UserDataPage extends StatefulWidget {
  final User user;
  const UserDataPage({super.key, required this.user});

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  String errorMessage = '';
  bool isLoading = false;

  // Helper method to validate inputs
  bool validateInputs() {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        ageController.text.isEmpty ||
        languageController.text.isEmpty) {
      setState(() {
        errorMessage = 'All fields are required.';
      });
      return false;
    }

    // Validate phone number format
    if (!RegExp(r'^\+?\d{10,15}$').hasMatch(phoneController.text)) {
      setState(() {
        errorMessage = 'Please enter a valid phone number.';
      });
      return false;
    }

    // Validate age
    final age = int.tryParse(ageController.text);
    if (age == null || age < 1 || age > 120) {
      setState(() {
        errorMessage = 'Please enter a valid age (1-120).';
      });
      return false;
    }

    setState(() {
      errorMessage = '';
    });
    return true;
  }

  Future<void> saveUserDetails() async {
    if (!validateInputs()) return;

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('users').doc(widget.user.uid).set({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'age': int.parse(ageController.text.trim()),
        'preferredLanguage': languageController.text.trim(),
        'email': widget.user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to save user details. Please try again.';
      });
      debugPrint('Error saving user details: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: languageController,
                  decoration: InputDecoration(
                    labelText: 'Preferred Language',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: saveUserDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Center(
                    child: Text(
                      'Save and Continue',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
