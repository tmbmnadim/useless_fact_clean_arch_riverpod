import '../repository/logger_repository.dart';

class ClearLogsUC {
  final LoggerRepository repository;

  ClearLogsUC(this.repository);

  Future<void> call() {
    return repository.clearLogs();
  }
}
