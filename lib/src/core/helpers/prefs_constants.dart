import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FSPrefs {
  static const userData = 'userData';
  static const expDateTime = 'userExpDateTime';
  static const userID = 'userID';
  static const userDocID = 'UserDocID';
  static const userImageUrl = 'userImageUrl';
  static const userName = 'userName';
  static const userToken = 'userToken';

  static Future<Map<String, Object>> getUserPrefsMap() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(FSPrefs.userData)) {
      return <String, Object>{};
    }
    final extractedUserData = jsonDecode(prefs.getString(FSPrefs.userData)!);
    return extractedUserData;
  }
}
