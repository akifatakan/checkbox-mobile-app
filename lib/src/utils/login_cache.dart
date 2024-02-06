import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class LoginCache {
  static const _userKey = 'user_data';
  static const _timestampKey = 'user_timestamp';
  static const _biometricKey = 'biometric_enabled'; // Key for biometric preference

  static Future<void> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = json.encode(user.toJson());
    await prefs.setString(_userKey, userJson);
    await prefs.setInt(_timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userTimestamp = prefs.getInt(_timestampKey);
    if (userTimestamp != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final cacheDuration = Duration(days: 7); // Or Duration(days: 1) for 1 day
      if (currentTime - userTimestamp < cacheDuration.inMilliseconds) {
        String? userJson = prefs.getString(_userKey);
        if (userJson != null) {
          return UserModel.fromJson(json.decode(userJson));
        }
      }
    }
    return null;
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_timestampKey);
  }

  // Save biometric preference
  static Future<void> saveBiometricPreference(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricKey, isEnabled);
  }

  // Retrieve biometric preference
  static Future<bool> getBiometricPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricKey) ?? false; // Default to false if not set
  }
}
