// import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  // static LocalStorage storage = LocalStorage('ollie_photo_social');
  static SharedPreferences prefs;

  static Future<String> getToken() async {
    return await getValue('token');
  }

  static Future<void> setToken(String token) async {
    await setValue('token', token);
  }

  static Future<String> getMoibileNumber() async {
    return await getValue('mobile');
  }

  static Future<void> setMoibileNumber(String mobile) async {
    await setValue('mobile', mobile);
  }

  static Future<String> getUsername() async {
    return await getValue('name');
  }

  static Future<void> setUsername(String name) async {
    await setValue('name', name);
  }

  static Future<String> getAvatar() async {
    return await getValue('avatar');
  }

  static Future<void> setAvatar(String avatar) async {
    await setValue('avatar', avatar);
  }

  static Future<String> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> setValue(String key, String val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }
}
