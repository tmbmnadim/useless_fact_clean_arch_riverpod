import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/features/logger/domain/usecase/log_error_usecase.dart';
import 'package:mood_log_tests/features/useless_facts/domain/entities/useless_fact_entity.dart';
import 'package:mood_log_tests/features/useless_facts/domain/usecase/useless_fact_usecase.dart';

import '../../../injector.dart';

class UselessFactController extends Notifier<UselessFactState> {
  late GetUselessFact _getUselessFact;
  late CreateLogUC _logger;

  @override
  UselessFactState build() {
    _getUselessFact = ref.read(getUselessFactUC);
    _logger = ref.read(createLogUsecaseProvider);
    return UselessFactState.initial();
  }

  Future<void> getAFact() async {
    try {
      _logger.call("$runtimeType<getAFact> called");
      if (state.isInitial) {
        state = UselessFactState.loading(uselessFact: state.uselessFact);
      }

      DataState<UselessFact> num = await _getUselessFact();
      if (num is DataSuccess) {
        _logger.call("$runtimeType<getAFact> data fetched successfully");
        state = UselessFactState.success(num.data!);
      } else {
        _logger.call("$runtimeType<getAFact> error: ${num.message}");
        state = UselessFactState.failure(num.message);
      }
    } catch (e) {
      _logger.call("$runtimeType<getAFact> error: $e");
      state = UselessFactState.failure(e.toString());
    }
  }
}

class UselessFactState {
  UselessFact? uselessFact;
  String? message;
  int? status;
  UselessFactState({this.uselessFact, this.message, this.status});

  static UselessFactState initial() {
    return UselessFactState();
  }

  static UselessFactState loading({UselessFact? uselessFact, String? message}) {
    return UselessFactState(
      uselessFact: uselessFact,
      status: 1,
      message: message,
    );
  }

  static UselessFactState success(UselessFact uselessFact, {String? message}) {
    return UselessFactState(
      uselessFact: uselessFact,
      status: 0,
      message: message,
    );
  }

  static UselessFactState failure(String? message) {
    return UselessFactState(message: message, status: -1);
  }

  bool get isInitial => status == null;
  bool get isLoading => status == 1;
  bool get isSuccess => status == 0;
  bool get isFailure => status == -1;
}
