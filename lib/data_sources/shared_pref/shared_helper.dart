import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys {
  userName,
}

class SharedHelper {
  // Private constructor
  SharedHelper._privateConstructor();

  // Singleton instance
  static final SharedHelper _instance = SharedHelper._privateConstructor();

  // Shared Preferences instance
  static SharedPreferences? _preferences;

  // Singleton getter
  static SharedHelper get instance => _instance;

  // Initialize SharedPreferences
  Future<void> init() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  // Set data methods
  Future<void> setString(PrefKeys key, String value) async {
    await _preferences?.setString(key.name, value);
  }

  Future<void> setInt(PrefKeys key, int value) async {
    await _preferences?.setInt(key.name, value);
  }

  Future<void> setBool(PrefKeys key, bool value) async {
    await _preferences?.setBool(key.name, value);
  }

  // Get data methods
  String? getString(PrefKeys key) {
    return _preferences?.getString(key.name);
  }

  int? getInt(PrefKeys key) {
    return _preferences?.getInt(key.name);
  }

  bool? getBool(PrefKeys key) {
    return _preferences?.getBool(key.name);
  }

  // Remove data method
  Future<void> remove(PrefKeys key) async {
    await _preferences?.remove(key.name);
  }

  // Clear all data
  Future<void> clear() async {
    await _preferences?.clear();
  }
}
