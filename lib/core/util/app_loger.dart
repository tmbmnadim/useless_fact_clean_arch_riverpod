import 'dart:io';

import 'package:logger/logger.dart';
import 'package:mood_log_tests/core/util/file_log_output.dart';

class AppLogger {
  static late final Logger _logger;
  static final FileLogOutput _fileOutput = FileLogOutput();

  static Future<void> init() async {
    _logger = Logger(printer: PrettyPrinter(), output: _fileOutput);
  }

  static void logError(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static Future<File> getLogFile() async => await _fileOutput.logFile;
}
