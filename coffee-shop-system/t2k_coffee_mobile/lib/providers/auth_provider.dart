import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;
  bool get isAdmin => _currentUser?.isAdmin ?? false;
  bool get isStaff => _currentUser?.isStaff ?? false;
  bool get isCustomer => _currentUser?.isCustomer ?? false;

  // Initialize provider
  Future<void> initialize() async {
    _setLoading(true);
    try {
      await _apiService.initialize();
      _currentUser = _apiService.currentUser;
      _clearError();
    } catch (e) {
      _setError('Failed to initialize: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Login
  Future<bool> login(String username, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await _apiService.login(username, password);

      if (result['token'] != null) {
        _currentUser = _apiService.currentUser;
        notifyListeners();
        return true;
      } else {
        _setError('Login failed: ${result['message'] ?? 'Unknown error'}');
        return false;
      }
    } catch (e) {
      _setError('Login failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _apiService.logout();
      _currentUser = null;
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Logout failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    String? fullName,
    String? phone,
    String? address,
  }) async {
    if (_currentUser == null) return false;

    _setLoading(true);
    _clearError();

    try {
      // This would typically call an API to update the profile
      // For now, we'll just update the local user object
      _currentUser = _currentUser!.copyWith(
        fullName: fullName ?? _currentUser!.fullName,
        phone: phone ?? _currentUser!.phone,
        address: address ?? _currentUser!.address,
      );

      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to update profile: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Register new user
  Future<bool> register({
    required String username,
    required String password,
    required String fullName,
    required String email,
    required String phone,
    required String role,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final success = await _apiService.register(
        username: username,
        password: password,
        fullName: fullName,
        email: email,
        phone: phone,
        role: role,
      );

      if (success) {
        _clearError();
        return true;
      } else {
        _setError('Đăng ký thất bại. Vui lòng thử lại.');
        return false;
      }
    } catch (e) {
      _setError('Đăng ký thất bại: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update reward points
  void updateRewardPoints(int points) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(rewardPoints: points);
      notifyListeners();
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }
}
