import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;

  Future<bool> sendOtp(String phone) async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
    return true; // Success
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (otp == '123456') { // Mock OTP
      _user = UserModel(
        id: 'u1',
        phone: phone,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}