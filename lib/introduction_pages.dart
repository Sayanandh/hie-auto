import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionPages extends StatefulWidget {
  const IntroductionPages({super.key});

  @override
  State<IntroductionPages> createState() => _IntroductionPagesState();
}

class _IntroductionPagesState extends State<IntroductionPages> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _completeOnboarding,
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          _buildPage(
            title: 'The best car in your hands with Ryde',
            description: 'Discover the convenience of finding your perfect ride with our Ryde App',
            image: 'assets/introduction1.png', // Replace with your assets
          ),
          _buildPage(
            title: 'The perfect ride is just a tap away!',
            description: 'Your journey begins with Ryde. Find your ideal ride effortlessly.',
            image: 'assets/introduction2.png', // Replace with your assets
          ),
          _buildPage(
            title: 'Your ride, your way. Let\'s get started!',
            description: 'Enter your destination, sit back, and let us take care of the rest.',
            image: 'assets/introduction3.png', // Replace with your assets
          ),
        ],
      ),
      bottomSheet: _currentPage == 2
          ? ElevatedButton(
              onPressed: _completeOnboarding,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                backgroundColor: Colors.blue, // Adjust based on design
              ),
              child: const Text('Get Started'),
            )
          : TextButton(
              onPressed: _nextPage,
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.blue),
              ),
            ),
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: 250, height: 250),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
