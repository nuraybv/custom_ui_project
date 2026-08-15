import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Autentifikasiya vəziyyətini saxlamaq üçün model
class AuthState {
  final bool isAuthenticated;
  final String? email;

  AuthState({required this.isAuthenticated, this.email});
}

// Riverpod Notifier vasitəsilə state idarəetməsi
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _loadInitialState();
    return AuthState(isAuthenticated: false, email: null);
  }

  Future<void> _loadInitialState() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuth = prefs.getBool('is_authenticated') ?? false;
    final email = prefs.getString('current_email');
    state = AuthState(isAuthenticated: isAuth, email: email);
  }

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email.isNotEmpty && password.length >= 6) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_authenticated', true);
      await prefs.setString('current_email', email);
      state = AuthState(isAuthenticated: true, email: email);
    } else {
      throw Exception('Invalid email or password');
    }
  }

  Future<void> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email.isNotEmpty && password.length >= 6) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_authenticated', true);
      await prefs.setString('current_email', email);
      state = AuthState(isAuthenticated: true, email: email);
    } else {
      throw Exception('Registration failed');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_authenticated');
    await prefs.remove('current_email');
    state = AuthState(isAuthenticated: false, email: null);
  }
}

// Qlobal Riverpod Provider
final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});