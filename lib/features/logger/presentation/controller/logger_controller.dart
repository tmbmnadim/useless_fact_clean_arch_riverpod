import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/core/util/provider_manager.dart';
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
    try {
      state = state.copyWith(status: ControllerStateStatus.loading);
      final logs = (await _getLogs.call()).getData();

      state = state.copyWith(logs: logs, status: ControllerStateStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: ControllerStateStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> addLog(String message) async {
    try {
      state = state.copyWith(status: ControllerStateStatus.loading);
      final dataState = await _createLog.call(message);
      dataState.getData();
    } catch (e) {
      state = LogState(logs: [], error: e.toString());
    }
  }

  Future<void> clear() async {
    await _clearLogs.call();
    await fetchLogs();
  }
}

class LogState {
  final List<AppLog> logs;
  final ControllerStateStatus status;
  final String? error;

  LogState({
    required this.logs,
    this.status = ControllerStateStatus.initial,
    this.error,
  });

  factory LogState.initial() {
    return LogState(logs: [], status: ControllerStateStatus.initial);
  }

  LogState copyWith({
    List<AppLog>? logs,
    ControllerStateStatus? status,
    String? error,
  }) {
    return LogState(
      logs: logs ?? this.logs,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
