import 'package:flutter/widgets.dart';
import 'package:mood_log_tests/core/util/datastate.dart';

import '../../domain/entities/log_entity.dart';
import '../../domain/repository/logger_repository.dart';
import '../source/log_source.dart';

class LoggerRepositoryImpl implements LoggerRepository {
  final LoggerSource source;

  LoggerRepositoryImpl(this.source);

  @override
  Future<DataState<void>> logError(String message) async {
    try {
      await source.writeLog(message);
      return DataSuccess(null);
    } catch (e) {
      return DataFailed(e.toString(), error: e);
    }
  }

  @override
  Future<DataState<List<AppLog>>> getLogs() async {
    try {
      final data = await source.readLogs();
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString(), error: e);
    }
  }

  @override
  Future<DataState<void>> clearLogs() async {
    try {
      await source.clearLogs();
      return DataSuccess(null);
    } catch (e) {
      return DataFailed(e.toString(), error: e);
    }
  }
}
