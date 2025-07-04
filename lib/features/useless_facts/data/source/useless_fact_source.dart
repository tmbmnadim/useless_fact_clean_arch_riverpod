import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mood_log_tests/features/useless_facts/data/models/useless_fact_model.dart';

class UselessFactSource {
  final Dio _dio = Dio();
  UselessFactSource();
  Future<UselessFactModel> getUselessFact() async {
    try {
      final res = await _dio.request(
        "https://uselessfacts.jsph.pl/api/v2/facts/random",
      );
      if (res.statusCode != 200) {
        throw "${res.statusCode}:${res.statusMessage}";
      }

      return UselessFactModel.fromJson(res.data);
    } catch (e, s) {
      debugPrint("UselessFactSource<getUselessFact>: $e\n$s");
      rethrow;
    }
  }
}
