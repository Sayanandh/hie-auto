import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  void makePayment(BuildContext context) {
    // Implement payment logic here
    // After the payment logic is successful, navigate to the home page
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
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
              'Fare: \$50',
              style: TextStyle(
                fontFamily: 'CustomFont', // Custom font for fare text
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => makePayment(context),
              child: const Text(
                'Pay Now',
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
