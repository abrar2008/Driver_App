import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys {
  static const String gcmToken = 'gcmToken';
  static const String userData = 'USER-DATA';
  static const String saved_user = 'SAVED-USER';
  static const String token = 'TOKEN';
  static const String SUPPORT_ROOM_ID = 'SUPPORT_ROOM_ID';
  static const String fcmToken = 'FCM_TOKEN';
  static const String firstLaunch = 'firstLaunch';
  static const String isDark = 'isDark';
  static const String languageCode = 'language_code';
  static const String userLogged = 'userLogged';
  static const String userMobile = 'userMobile';
  static const String userPassword = 'userPassword';
  static const String locationPer = 'locationPer';
  static const String themeIndex = 'themeIndex';
  static const String lastNotificationOpen = 'lastNotificationOpen';
  static const String status = 'pending';
}

class Preference {
  static SharedPreferences sb;
  static Future<void> init() async {
    if (sb == null) sb = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    try {
      return sb.getString(key);
    } catch (e) {
      return null;
    }
  }

  static int getInt(String key) {
    try {
      return sb.getInt(key);
    } catch (e) {
      return null;
    }
  }

  static bool getBool(String key) {
    try {
      return sb.getBool(key);
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> setString(String key, String value) async {
    final sb = await SharedPreferences.getInstance();
    try {
      return sb.setString(key, value);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> setInt(String key, int value) async {
    try {
      return sb.setInt(key, value);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> setBool(String key, bool value) async {
    try {
      print(key);
      return await sb.setBool(key, value);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> remove(String key) async {
    try {
      return await sb.remove(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> clear() async {
    try {
      return await sb.clear();
    } catch (e) {
      return null;
    }
  }
}
