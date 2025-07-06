import 'dart:ui';

import 'package:mood_log_tests/features/useless_facts/presentation/controller/useless_fact_controller.dart';

class FakeUselessFactController extends UselessFactController {
  UselessFactState _state;
  // ignore: avoid_public_notifier_properties
  final VoidCallback? onFactCalled;
  bool getAFactCalled = false;

  FakeUselessFactController({
    required UselessFactState state,
    this.onFactCalled,
  }) : _state = state;

  @override
  UselessFactState build() => _state;

  void setState(UselessFactState state) => _state = state;

  @override
  Future<void> getAFact() async {
    getAFactCalled = true;
    onFactCalled?.call();
  }
}
