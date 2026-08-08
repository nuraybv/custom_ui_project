import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _currentUserEmail;

  bool get isAuthenticated => _isAuthenticated;
  String? get currentUserEmail => _currentUserEmail;

  AuthService() {
    _loadAuthStatus(); // Tətbiq açılan kimi yaddaşdan oxuyuruq
  }

  // Yaddaşdan əvvəlki giriş statusunu yoxlamaq
  Future<void> _loadAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('is_authenticated') ?? false;
    _currentUserEmail = prefs.getString('current_email');
    notifyListeners();
  }

  // Mock login logic with SharedPreferences storage
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (email.isNotEmpty && password.length >= 6) {
      _isAuthenticated = true;
      _currentUserEmail = email;

      // Statusu yaddaşda saxlayırıq
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_authenticated', true);
      await prefs.setString('current_email', email);

      notifyListeners();
      return true;
    }
    throw Exception('Invalid email or password');
  }

  // Mock registration logic
  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (email.isNotEmpty && password.length >= 6) {
      _isAuthenticated = true;
      _currentUserEmail = email;

      // Statusu yaddaşda saxlayırıq
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_authenticated', true);
      await prefs.setString('current_email', email);

      notifyListeners();
      return true;
    }
    throw Exception('Registration failed');
  }

  // Logout logic to clear session state and local storage
  Future<void> logout() async {
    _isAuthenticated = false;
    _currentUserEmail = null;

    // Yaddaşı təmizləyirik
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_authenticated');
    await prefs.remove('current_email');

    notifyListeners();
  }
}