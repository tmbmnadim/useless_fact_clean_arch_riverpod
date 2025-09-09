import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mood_log_tests/features/user/data/models/user_model.dart';

class UserSourceNetwork {
  UserSourceNetwork();
  String? _base = dotenv.env['server_link'];

  Future<UserModel> createUser(UserModel user) async {
    try {
      _base ??= dotenv.env['server_link'];
      if (_base == null || (_base ?? "").isEmpty) {
        throw "Base url is empty";
      }
      debugPrint("THE BASE URL: $_base");
      Uri? baseUri = Uri.tryParse("http://$_base/users/");
      if (baseUri == null) {
        throw "Server url is empty";
      }
      Map<String, String> headers = {"Content-Type": "application/json"};
      Map<String, dynamic> body = user.toJson();

      final response = await http.post(
        baseUri,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode != 200) {
        throw response.reasonPhrase ?? "Something went wrong!";
      }
      return UserModel.fromJson(jsonDecode(response.body));
    } catch (e, s) {
      debugPrint("UserSourceNetwork<createUser>: $e\n$s");
      rethrow;
    }
  }

  Future<UserModel> getUser([int? userID]) async {
    try {
      if (userID == null) {
        throw "User id is null";
      }
      Uri? baseUri = Uri.tryParse("http://$_base/users/$userID");
      if (baseUri == null) {
        throw "Server url is empty";
      }

      final response = await http.get(baseUri);
      final data = response.body;
      if (response.statusCode != 200) {
        throw response.reasonPhrase ?? "Something went wrong!";
      }
      final user = jsonDecode(data);
      return UserModel.fromJson(user);
    } catch (e, s) {
      debugPrint("UserSourceNetwork<getUser>: $e\n$s");
      rethrow;
    }
  }
}
