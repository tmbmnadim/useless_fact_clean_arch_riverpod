import 'package:mood_log_tests/core/util/datastate.dart';

import '../repository/logger_repository.dart';

class ClearLogsUC {
  final LoggerRepository repository;

  ClearLogsUC(this.repository);

  Future<DataState> call() {
    return repository.clearLogs();
  }
}
