import 'dart:convert';

import 'package:pets_app/models/user/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static const String userJsonKey = 'userJson';
  static const String firstLaunchKey = 'firstLaunch';

  static SharedPreferences? _prefs;

  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> setUserJson(AppUser? user) async {
    if (_prefs != null && user != null) {
      await _prefs!.setString(userJsonKey, jsonEncode(user.toJson()));
    }
  }

  static AppUser? getUser() {
    final userJson = _prefs?.getString(userJsonKey);
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson) ?? {};
      return AppUser.fromJson(userMap);
    }
    return null;
  }

  static Future<void> setFirstLaunch(bool isFirstLaunch) async {
    if (_prefs != null) {
      await _prefs!.setBool(firstLaunchKey, isFirstLaunch);
    }
  }

  static bool isFirstLaunch() {
    return _prefs?.getBool(firstLaunchKey) ?? true;
  }

  static Future<void> clearPreferences() async {
    if (_prefs != null) {
      await _prefs!.clear();
      await setFirstLaunch(false);
    }
  }
}
