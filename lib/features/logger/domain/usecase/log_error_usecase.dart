// lib/features/logger/domain/usecases/log_error.dart
import 'package:mood_log_tests/core/util/datastate.dart';

import '../repository/logger_repository.dart';

class CreateLogUC {
  final LoggerRepository repository;

  CreateLogUC(this.repository);

  Future<DataState> call(String message) {
    return repository.logError(message);
  }
}
