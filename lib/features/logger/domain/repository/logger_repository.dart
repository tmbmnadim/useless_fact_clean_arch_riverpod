import '../entities/log_entity.dart';

abstract class LoggerRepository {
  Future<void> logError(String message);
  Future<List<AppLog>> getLogs();
  Future<void> clearLogs();
}
