// ignore: file_names
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  void setBoolCache(String key, bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  void removeBoolCache(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }

  Future<bool?> getBoolCache(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }
}
