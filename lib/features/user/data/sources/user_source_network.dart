import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mood_log_tests/features/user/data/models/user_model.dart';

class UserSourceNetwork {
  UserSourceNetwork();
  final String? _base = dotenv.env['server_link'];

  Future<UserModel> createUser(UserModel user) async {
    try {
      Uri? baseUri = Uri.tryParse("$_base/users");
      if (baseUri == null) {
        throw "Server url is empty";
      }
      Map<String, String> headers = {};
      Map<String, dynamic> body = user.toJson();

      final response = await http.post(baseUri, headers: headers, body: body);
      if (response.statusCode != 200) {
        throw response.reasonPhrase ?? "Something went wrong!";
      }
      return UserModel.fromJson(jsonDecode(response.body));
    } catch (e, s) {
      debugPrint("UserSourceNetwork<createUser>: $e\n$s");
      rethrow;
    }
  }

  Future<UserModel> getUser(String userID) async {
    try {
      Uri? baseUri = Uri.tryParse("$_base/users");
      if (baseUri == null) {
        throw "Server url is empty";
      }

      final response = await http.get(baseUri);
      final data = response.body;
      if (response.statusCode != 200) {
        throw response.reasonPhrase ?? "Something went wrong!";
      }
      final List<Map<String, dynamic>> users = jsonDecode(data);

      for (var user in users) {
        if (user["id"] == userID) {
          return UserModel.fromJson(user);
        }
      }
      throw "User not found";
    } catch (e, s) {
      debugPrint("UserSourceNetwork<getUser>: $e\n$s");
      rethrow;
    }
  }
}
