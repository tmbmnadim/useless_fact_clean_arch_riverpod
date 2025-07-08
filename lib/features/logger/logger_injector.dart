import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/source/log_source.dart';
import 'domain/repository/logger_repository.dart';
import 'data/repository/log_repository_impl.dart';
import 'domain/usecase/clear_logs.dart';
import 'domain/usecase/get_logs.dart';
import 'domain/usecase/log_error_usecase.dart';
import 'presentation/controller/logger_controller.dart';

// lib/injector.dart or logger_injector.dart
final loggerSourceProvider = Provider<LoggerSource>((ref) {
  return LoggerSource();
});

final loggerRepositoryProvider = Provider<LoggerRepository>((ref) {
  final source = ref.read(loggerSourceProvider);
  return LoggerRepositoryImpl(source);
});

final createLogUsecaseProvider = Provider<CreateLogUC>((ref) {
  final repo = ref.read(loggerRepositoryProvider);
  return CreateLogUC(repo);
});

final getLogsUsecaseProvider = Provider<GetLogsUC>((ref) {
  final repo = ref.read(loggerRepositoryProvider);
  return GetLogsUC(repo);
});

final clearLogsUsecaseProvider = Provider<ClearLogsUC>((ref) {
  final repo = ref.read(loggerRepositoryProvider);
  return ClearLogsUC(repo);
});

final logControllerProvider = NotifierProvider<LogController, LogState>(() {
  return LogController();
});
