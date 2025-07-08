import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_log_tests/features/useless_facts/domain/entities/useless_fact_entity.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/controller/useless_fact_controller.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/pages/homepage.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/widgets/useless_fact_card.dart';
import 'package:mood_log_tests/features/useless_facts/useless_fact_injector.dart';

import 'fake_notifier.dart';

void main() {
  late FakeUselessFactController fakeController;

  final testFact = UselessFact(id: "abc", text: "Don't be useless!");

  setUp(() {
    fakeController = FakeUselessFactController(
      state: UselessFactState.initial(),
      onFactCalled: () {},
    );
  });

  Widget buildTestableWidget() {
    return ProviderScope(
      overrides: [uselessFactProvider.overrideWith(() => fakeController)],
      child: MaterialApp(home: const UselessFactPresentor()),
    );
  }

  testWidgets('Displays initial message', (tester) async {
    fakeController.setState(UselessFactState.initial());

    await tester.pumpWidget(buildTestableWidget());

    expect(find.textContaining('Press the button'), findsOneWidget);
  });

  testWidgets('Displays loading spinner', (tester) async {
    fakeController.setState(UselessFactState.loading());

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays success fact card', (tester) async {
    fakeController.setState(UselessFactState.success(testFact));

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(UselessFactCard), findsOneWidget);
    expect(find.text("Don't be useless!"), findsOneWidget);
  });

  testWidgets('Displays error message', (tester) async {
    fakeController.setState(UselessFactState.failure("Error"));

    await tester.pumpWidget(buildTestableWidget());

    expect(find.textContaining("Error"), findsOneWidget);
  });

  testWidgets('Button tap triggers getAFact()', (tester) async {
    fakeController.setState(UselessFactState.initial());
    fakeController.setState(UselessFactState.initial());

    await tester.pumpWidget(buildTestableWidget());

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(fakeController.getAFactCalled, true);
  });
}
