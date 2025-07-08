import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_log_tests/features/logger/domain/usecase/log_error_usecase.dart';
import 'package:mood_log_tests/features/logger/logger_injector.dart';

import '../../domain/entities/log_entity.dart';
import '../../domain/usecase/clear_logs.dart';
import '../../domain/usecase/get_logs.dart';

class LogController extends Notifier<LogState> {
  late final CreateLogUC _createLog;
  late final GetLogsUC _getLogs;
  late final ClearLogsUC _clearLogs;

  @override
  LogState build() {
    _createLog = ref.read(createLogUsecaseProvider);
    _getLogs = ref.read(getLogsUsecaseProvider);
    _clearLogs = ref.read(clearLogsUsecaseProvider);

    return LogState.initial();
  }

  Future<void> fetchLogs() async {
    state = LogState(logs: state.logs, isLoading: true);
    try {
      final logs = await _getLogs.call();
      state = LogState(logs: logs);
    } catch (e) {
      state = LogState(logs: [], error: e.toString());
    }
  }

  Future<void> addLog(String message) async {
    await _createLog.call(message);
    await fetchLogs();
  }

  Future<void> clear() async {
    await _clearLogs.call();
    await fetchLogs();
  }
}

class LogState {
  final List<AppLog> logs;
  final bool isLoading;
  final String? error;

  LogState({required this.logs, this.isLoading = false, this.error});

  factory LogState.initial() => LogState(logs: []);
}
