import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPreferenceHelper{
  
  static final String _keyOfTitle = "title";
  
  static Future<String> getTitle() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_keyOfTitle) ?? 'name';
  }

  static void setTitle(String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_keyOfTitle, title);
  }

  static void removeTitle(String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(title);
  }
}
