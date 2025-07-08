import '../entities/log_entity.dart';
import '../repository/logger_repository.dart';

class GetLogsUC {
  final LoggerRepository repository;

  GetLogsUC(this.repository);

  Future<List<AppLog>> call() {
    return repository.getLogs();
  }
}
