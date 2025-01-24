import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'secrets.dart'; // Import the secrets file
import 'ride_nearby_page.dart';
import 'activity_page.dart';
import 'profile_page.dart';
import 'api_service.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logger = Logger();
  List<String> locationSuggestions = [];
  final TextEditingController searchController = TextEditingController();
  final MapController mapController = MapController();
  
  // Default to Kerala coordinates
  static const LatLng _center = LatLng(10.0261, 76.3125);
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.denied) {
          await _getCurrentLocation();
        }
      } else {
        await _getCurrentLocation();
      }
    } catch (e) {
      logger.e('Error requesting location permission: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        mapController.move(_currentLocation ?? _center, 15.0);
      });
    } catch (e) {
      logger.e('Error getting location: $e');
    }
  }

  /// Fetch location suggestions based on user input
  Future<void> _searchLocation(String query) async {
    try {
      final suggestions = await ApiService.getSuggestions(query);
      setState(() {
        locationSuggestions = suggestions;
      });
    } catch (e) {
      logger.e('Error getting suggestions: $e');
    }
  }

  /// Navigates to the RideNearbyPage
  void _navigateToRideNearby(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RideNearbyPage(),
      ),
    );
  }

  /// Navigates to the ActivityPage
  void _navigateToActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ActivityPage(),
      ),
    );
  }

  /// Navigates to the ProfilePage
  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome and Notification Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welcome, Guest',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      // Add notification functionality here if needed
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search Field
              TextField(
                controller: searchController,
                onChanged: _searchLocation,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Where do you want to go?',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Display location suggestions
              if (locationSuggestions.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: locationSuggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(locationSuggestions[index]),
                        onTap: () {
                          print('Selected location: ${locationSuggestions[index]}');
                          // Navigate or perform any action based on selected location
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 24),

              const Text(
                'Your Current Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Map Container
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: _currentLocation ?? _center,
                          initialZoom: 13.0,
                          maxZoom: 18.0,
                          minZoom: 3.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                            additionalOptions: {
                              'accessToken': Secrets.mapboxAccessToken,
                              'id': Secrets.mapboxStyleId,
                            },
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: _currentLocation ?? _center,
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: FloatingActionButton.small(
                          onPressed: _getCurrentLocation,
                          child: const Icon(Icons.my_location),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Current Ride',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Example current ride details card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Icon(Icons.location_on, size: 32, color: Colors.grey),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Behind SCMS',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Kadukuty',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Driver: Auto Driver | Seats: 4',
                          ),
                          Text(
                            'Payment Status: Paid',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      /// Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 22,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.history),
              onPressed: () => _navigateToActivity(context),
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () => _navigateToProfile(context),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
