import 'package:mood_log_tests/core/util/datastate.dart';

import '../entities/log_entity.dart';
import '../repository/logger_repository.dart';

class GetLogsUC {
  final LoggerRepository repository;

  GetLogsUC(this.repository);

  Future<DataState<List<AppLog>>> call() {
    return repository.getLogs();
  }
}
