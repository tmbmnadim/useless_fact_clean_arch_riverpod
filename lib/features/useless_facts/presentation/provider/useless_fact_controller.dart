import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/features/useless_facts/domain/entities/useless_fact_entity.dart';
import 'package:mood_log_tests/features/useless_facts/domain/usecase/useless_fact_usecase.dart';

class UselessFactController extends StateNotifier<UselessFactState> {
  final GetUselessFact _getCatFact;
  UselessFactController(this._getCatFact) : super(UselessFactState.initial());

  Future<void> getAFact() async {
    if (state.isInitial) {
      state = UselessFactState.loading(state.uselessFact);
    }

    DataState<UselessFact> num = await _getCatFact();
    if (num is DataSuccess) {
      state = UselessFactState.success(num.data!);
    } else {
      state = UselessFactState.failure(num.message);
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

  static UselessFactState loading(UselessFact? uselessFact, {String? message}) {
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
