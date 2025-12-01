import 'package:app_clone/models/user_model.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  /// simulated authentication methods (to be replaced with firebase later)
  Future<User?> loginWithRole(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await Future.delayed(const Duration(seconds: 2));
      return _currentUser;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      //simulate API call
      await Future.delayed(const Duration(seconds: 2));

      //create new user (replace with Firebase auth)
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: fullName,
        email: email,
      );
      return _currentUser;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;

    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      //simulate API call
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //helper method to determine initial route
  String getInitialRoute() {
    if (_currentUser == null) return '/auth';
    return '/home';
  }
}
