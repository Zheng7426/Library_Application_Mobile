import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PersistentStorage {
  static void clearSavedData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, ' ');
  }

  static Future<Map> loadSavedData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String string = sharedPreferences.getString(key) ?? " ";
    Map<String, dynamic> decoded = (string != " ") ? json.decode(string) : {};
    return decoded;
  }

  static void saveData(String key, Map<String, dynamic> map) async {
    String encoded = json.encode(map);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, encoded);
  }
}
