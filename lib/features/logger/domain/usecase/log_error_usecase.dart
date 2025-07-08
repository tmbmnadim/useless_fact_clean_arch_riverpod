// lib/features/logger/domain/usecases/log_error.dart
import '../repository/logger_repository.dart';

class CreateLogUC {
  final LoggerRepository repository;

  CreateLogUC(this.repository);

  Future<void> call(String message) {
    return repository.logError(message);
  }
}
