import 'package:mood_log_tests/core/util/datastate.dart';

import '../entities/log_entity.dart';

abstract class LoggerRepository {
  Future<DataState<void>> logError(String message);
  Future<DataState<List<AppLog>>> getLogs();
  Future<DataState<void>> clearLogs();
}
