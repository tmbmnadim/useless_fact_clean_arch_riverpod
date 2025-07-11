import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:mood_log_tests/features/logger/data/models/log_model.dart';
import 'package:path_provider/path_provider.dart';

class LoggerSource {
  Future<File?> _getLogFile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      return File("${dir.path}/app_logs.txt");
    } catch (e, s) {
      debugPrint("LoggerSource<_getLogFile> Error: $e\n$s");
      rethrow;
    }
  }

  Future<void> writeLog(String message) async {
    try {
      final log = "[${DateTime.now().toIso8601String()}] $message\n";
      final file = await _getLogFile();
      if (file != null) {
        await file.writeAsString(log, mode: FileMode.append);
      } else {
        throw Exception("File Not Found");
      }
    } catch (e, s) {
      debugPrint("LoggerSource<_getLogFile> Error: $e\n$s");
      rethrow;
    }
  }

  Future<List<AppLogModel>> readLogs() async {
    try {
      final file = await _getLogFile();
      if (file == null) throw Exception("File not found");
      if (!await file.exists()) return [];

      final lines = await file.readAsLines();
      return lines
          .map((line) {
            final parts = line.split("] ");
            if (parts.length < 2) return null;
            final timestamp = DateTime.tryParse(parts[0].substring(1));
            if (timestamp == null) return null;
            return AppLogModel(message: parts[1], timestamp: timestamp);
          })
          .whereType<AppLogModel>()
          .toList()
          .reversed
          .toList(); // Show newest first
    } catch (e, s) {
      debugPrint("LoggerSource<_getLogFile> Error: $e\n$s");
      rethrow;
    }
  }

  Future<void> clearLogs() async {
    try {
      final file = await _getLogFile();
      if (file == null) throw Exception("File not found!");
      if (await file.exists()) await file.writeAsString('');
    } catch (e, s) {
      debugPrint("LoggerSource<_getLogFile> Error: $e\n$s");
      rethrow;
    }
  }
}
