import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _currentUserEmail;

  bool get isAuthenticated => _isAuthenticated;
  String? get currentUserEmail => _currentUserEmail;

  // Mock login logic with simulated network delay
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (email.isNotEmpty && password.length >= 6) {
      _isAuthenticated = true;
      _currentUserEmail = email;
      notifyListeners();
      return true;
    }
    throw Exception('Invalid email or password');
  }

  // Mock registration logic with simulated network delay
  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (email.isNotEmpty && password.length >= 6) {
      _isAuthenticated = true;
      _currentUserEmail = email;
      notifyListeners();
      return true;
    }
    throw Exception('Registration failed');
  }

  // Logout logic
  void logout() {
    _isAuthenticated = false;
    _currentUserEmail = null;
    notifyListeners();
  }
}