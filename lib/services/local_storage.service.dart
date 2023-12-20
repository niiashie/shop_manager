import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future _prefs() {
    return SharedPreferences.getInstance();
  }

  static Future<void> save(String key, value) async {
    final prefs = await _prefs();
    prefs.setString(key, value);
  }

  static Future<String?> read(String key) async {
    final prefs = await _prefs();
    var data = prefs.getString(key);
    return data; //data == null ? null : data;
  }

  // Model Operations
  static void saveModel(String key, value) async {
    var encodedValue = json.encode(value);
    save(key, encodedValue);
  }

  static Future<dynamic> readModel(String key) async {
    var encodedValue = await read(key);
    return encodedValue == null ? null : json.decode(encodedValue);
  }

  // Generic
  static Future<dynamic> getPref<T>(String key, T type) async {
    final prefs = await _prefs();
    if (type is String) {
      return prefs.getString(key) ?? 0;
    } else if (type is int) {
      return prefs.getInt(key) ?? 0;
    } else if (type is List<String>) {
      return prefs.getStringList(key) ?? [];
    } else if (type is bool) {
      return prefs.getBool(key) ?? type;
    } else {
      return null;
    }
  }

  static dynamic setPref<T>(String key, T value) async {
    final prefs = await _prefs();
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      prefs.setString(key, value.toString());
    }
  }
}
