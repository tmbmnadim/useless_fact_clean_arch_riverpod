import '../../domain/entities/log_entity.dart';
import '../../domain/repository/logger_repository.dart';
import '../source/log_source.dart';

class LoggerRepositoryImpl implements LoggerRepository {
  final LoggerSource source;

  LoggerRepositoryImpl(this.source);

  @override
  Future<void> logError(String message) => source.writeLog(message);

  @override
  Future<List<AppLog>> getLogs() => source.readLogs();

  @override
  Future<void> clearLogs() => source.clearLogs();
}
