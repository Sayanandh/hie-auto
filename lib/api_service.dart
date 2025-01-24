import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class ApiService {
  static const String baseUrl = 'https://4d1a-2a09-bac5-3da2-1aa0-00-2a7-1e.ngrok-free.app'; // Update with your API URL
  static final logger = Logger();
  
  // Get token from SharedPreferences
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Add token to headers
  static Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Helper method to handle API responses
  static dynamic _handleResponse(http.Response response) {
    logger.i('Response Status: ${response.statusCode}');
    logger.i('Response Body: ${response.body}');

    // Check if response is HTML (error page)
    if (response.body.trim().startsWith('<!DOCTYPE html>')) {
      throw Exception('Invalid server response. Please try again later.');
    }

    try {
      final data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Invalid response format from server');
      }
      rethrow;
    }
  }

  // Register User and Send OTP
  static Future<bool> registerUser(String email, String firstName, String lastName, String password) async {
    try {
      logger.i('Registering user: $email');
      
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "fullname": {
            "firstname": firstName,
            "lastname": lastName
          },
          "email": email,
          "password": password
        }),
      );

      final data = _handleResponse(response);
      return data['message']?.contains('OTP sent') ?? false;
    } catch (e) {
      logger.e('Registration error: $e');
      throw Exception('Registration failed: $e');
    }
  }

  static Future<Map<String, dynamic>> validateOtp({
    required String email,
    required String otp,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/validate-otp'),
      headers: await _getHeaders(),
      body: jsonEncode({
        'email': email,
        'otp': otp,
      }),
    );

    final data = jsonDecode(response.body);
    if (data['token'] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
    }
    return data;
  }

  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      logger.i('Login Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['token'] != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', data['token']);
        }
        return data;
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Login error: $e');
      throw Exception('Login failed: $e');
    }
  }

  static Future<Map<String, dynamic>> getUserProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/profile'),
      headers: await _getHeaders(),
    );
    return jsonDecode(response.body);
  }

  static Future<void> logout() async {
    await http.get(
      Uri.parse('$baseUrl/users/logout'),
      headers: await _getHeaders(),
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Captain APIs
  static Future<Map<String, dynamic>> registerCaptain({
    required Map<String, dynamic> captainData,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/captains/register'),
      headers: await _getHeaders(),
      body: jsonEncode(captainData),
    );
    return jsonDecode(response.body);
  }

  // Maps APIs
  static Future<Map<String, dynamic>> getCoordinates(String address) async {
    final response = await http.get(
      Uri.parse('$baseUrl/maps/get-coordinate?address=$address'),
      headers: await _getHeaders(),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getDistanceTime({
    required String origin,
    required String destination,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/maps/get-distance-time?origin=$origin&destination=$destination'),
      headers: await _getHeaders(),
    );
    return jsonDecode(response.body);
  }

  static Future<List<String>> getSuggestions(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/locations/suggestions?query=$query'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => item.toString()).toList();
      } else {
        return [];
      }
    } catch (e) {
      logger.e('Error getting suggestions: $e');
      return [];
    }
  }

  // AutoStand APIs
  static Future<Map<String, dynamic>> createAutoStand({
    required String standname,
    required double latitude,
    required double longitude,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/autostands/create'),
      headers: await _getHeaders(),
      body: jsonEncode({
        'standname': standname,
        'location': {
          'latitude': latitude,
          'longitude': longitude,
        },
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> updateAutoStand({
    required String id,
    String? standname,
    double? latitude,
    double? longitude,
  }) async {
    final Map<String, dynamic> updateData = {};
    if (standname != null) updateData['standname'] = standname;
    if (latitude != null && longitude != null) {
      updateData['location'] = {
        'latitude': latitude,
        'longitude': longitude,
      };
    }

    final response = await http.put(
      Uri.parse('$baseUrl/autostands/update/$id'),
      headers: await _getHeaders(),
      body: jsonEncode(updateData),
    );
    return jsonDecode(response.body);
  }

  static Future<void> deleteAutoStand(String id) async {
    await http.delete(
      Uri.parse('$baseUrl/autostands/delete/$id'),
      headers: await _getHeaders(),
    );
  }

  // Verify if server is accessible
  static Future<bool> checkServerConnection() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      return response.statusCode == 200;
    } catch (e) {
      logger.e('Server connection error: $e');
      return false;
    }
  }

  // Verify OTP
  static Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    try {
      logger.i('Verifying OTP - Email: $email, OTP: $otp');
      
      final response = await http.post(
        Uri.parse('$baseUrl/users/validate-otp'), // Updated endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'otp': otp,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      logger.e('OTP verification error: $e');
      throw Exception('OTP verification failed: $e');
    }
  }

  // Check if email/phone exists
  static Future<bool> checkIdentifierExists(String emailOrPhone) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/check-identifier'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'identifier': emailOrPhone,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['exists'] ?? false;
      } else {
        throw Exception('Failed to check identifier: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Check identifier error: $e');
      throw Exception('Failed to check identifier: $e');
    }
  }

  // Resend OTP
  static Future<bool> resendOtp(String email) async {
    try {
      logger.i('Resending OTP to: $email');
      
      final response = await http.post(
        Uri.parse('$baseUrl/users/resend-otp'), // Make sure this endpoint exists
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
        }),
      );

      final data = _handleResponse(response);
      return data['message']?.contains('OTP sent') ?? false;
    } catch (e) {
      logger.e('Resend OTP error: $e');
      throw Exception('Failed to resend OTP: $e');
    }
  }
} 