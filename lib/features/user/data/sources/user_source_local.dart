import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mood_log_tests/features/user/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSourceLocal {
  SharedPreferences? _prefs;

  Future<UserModel> getUser() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();

      final userString = _prefs!.getString("user");
      if (userString == null) {
        throw "No user saved";
      }
      final Map<String, dynamic> data = jsonDecode(userString);

      return UserModel.fromJson(data);
    } catch (e, s) {
      debugPrint("UserSourceLocal<getUserID>: $e\n$s");
      rethrow;
    }
  }

  Future<void> setUser(UserModel user) async {
    try {
      _prefs ??= await SharedPreferences.getInstance();

      _prefs!.setString("user", jsonEncode(user.toJson()));
    } catch (e, s) {
      debugPrint("UserSourceLocal<setUserID>: $e\n$s");
      rethrow;
    }
  }

  Future<String?> removeUser() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();

      _prefs!.remove("user");
      return null;
    } catch (e, s) {
      debugPrint("UserSourceLocal<setUserID>: $e\n$s");
    }
    return null;
  }
}
