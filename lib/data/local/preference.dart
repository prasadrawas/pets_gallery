import 'dart:convert';

import 'package:pets_app/models/user/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static const String userJsonKey = 'userJson';
  static const String firstLaunchKey = 'firstLaunch';

  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save user data to SharedPreferences
  static Future<void> setUserJson(AppUser? user) async {
    if (_prefs != null && user != null) {
      await _prefs!.setString(userJsonKey, jsonEncode(user.toJson()));
    }
  }

  // Retrieve user data from SharedPreferences
  static AppUser? getUser() {
    final userJson = _prefs?.getString(userJsonKey);
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson) ?? {};
      return AppUser.fromJson(userMap);
    }
    return null;
  }

  // Set the 'firstLaunch' flag in SharedPreferences
  static Future<void> setFirstLaunch(bool isFirstLaunch) async {
    if (_prefs != null) {
      await _prefs!.setBool(firstLaunchKey, isFirstLaunch);
    }
  }

  // Check if it's the first launch
  static bool isFirstLaunch() {
    return _prefs?.getBool(firstLaunchKey) ?? true;
  }

  // Clear all preferences and set 'firstLaunch' to false
  static Future<void> clearPreferences() async {
    if (_prefs != null) {
      await _prefs!.clear();
      await setFirstLaunch(false);
    }
  }
}
