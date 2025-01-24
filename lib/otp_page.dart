import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'api_service.dart';

class OtpPage extends StatefulWidget {
  final String email;
  final bool isSignup;
  
  const OtpPage({
    super.key, 
    required this.email,
    this.isSignup = false,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final _logger = Logger();
  bool _isLoading = false;
  String? _errorMessage;
  bool _autoVerify = false;

  @override
  void initState() {
    super.initState();
    // Only send OTP if this is a new signup
    if (widget.isSignup) {
      _resendOtp();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _resendOtp() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // First check if server is accessible
      final isServerUp = await ApiService.checkServerConnection();
      if (!mounted) return;

      if (!isServerUp) {
        setState(() {
          _errorMessage = 'Unable to connect to server. Please check your internet connection.';
        });
        return;
      }

      _logger.i('Requesting OTP for: ${widget.email}');
      final success = await ApiService.resendOtp(widget.email);
      
      if (!mounted) return;
      
      if (!success) {
        _logger.e('Failed to send OTP');
        setState(() {
          _errorMessage = 'Failed to send OTP. Please try again.';
        });
      } else {
        _logger.i('OTP sent successfully');
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP sent successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      _logger.e('Error sending OTP: $e');
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _verifyOtp() async {
    String otp = _controllers.map((c) => c.text).join();
    if (otp.length != 6) {
      _logger.w('Incomplete OTP entered');
      setState(() {
        _errorMessage = 'Please enter complete OTP';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      _logger.i('Verifying OTP for: ${widget.email}');
      final response = await ApiService.verifyOtp(widget.email, otp);
      
      if (!mounted) return;

      if (response['success'] == true) {
        _logger.i('OTP verified successfully');
        if (widget.isSignup) {
          Navigator.pushNamedAndRemoveUntil(
            context, 
            '/user-details', 
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context, 
            '/home', 
            (route) => false,
          );
        }
      } else {
        _logger.w('Invalid OTP entered');
        setState(() {
          _errorMessage = response['message'] ?? 'Invalid OTP';
        });
      }
    } catch (e) {
      _logger.e('Error verifying OTP: $e');
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter OTP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We have sent OTP to ${widget.email}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 50,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: const TextStyle(fontSize: 24),
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          }
                          // Only verify if all digits are entered and auto-verify is enabled
                          if (_autoVerify && value.isNotEmpty && index == 5) {
                            if (_controllers.every((controller) => controller.text.isNotEmpty)) {
                              _verifyOtp();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Verify OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't receive OTP?"),
                  TextButton(
                    onPressed: _isLoading ? null : _resendOtp,
                    child: Text(
                      _isLoading ? 'Sending...' : 'Resend OTP',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 