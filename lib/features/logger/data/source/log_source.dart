import 'dart:io';
import 'package:mood_log_tests/features/logger/data/models/log_model.dart';
import 'package:path_provider/path_provider.dart';

class LoggerSource {
  Future<File> _getLogFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/app_logs.txt");
  }

  Future<void> writeLog(String message) async {
    final log = "[${DateTime.now().toIso8601String()}] $message\n";
    final file = await _getLogFile();
    await file.writeAsString(log, mode: FileMode.append);
  }

  Future<List<AppLogModel>> readLogs() async {
    final file = await _getLogFile();
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
  }

  Future<void> clearLogs() async {
    final file = await _getLogFile();
    if (await file.exists()) await file.writeAsString('');
  }
}
