import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mood_log_tests/features/useless_facts/domain/entities/useless_fact_entity.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/controller/useless_fact_controller.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/pages/homepage.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/widgets/useless_fact_card.dart';
import 'package:mood_log_tests/injector.dart';

class MockUselessFactController extends Mock implements UselessFactController {}

void main() {
  late MockUselessFactController mockController;

  setUp(() {
    mockController = MockUselessFactController();
  });

  setUpAll(() {
    registerFallbackValue(UselessFactState.initial());
  });

  final testFact = UselessFact(id: "ABC", text: "Don't be useless!");
  UselessFactState initial = UselessFactState.initial();
  UselessFactState loading = UselessFactState.loading();
  UselessFactState success = UselessFactState.success(testFact);
  UselessFactState failure = UselessFactState.failure("testfailure");

  Widget buildTestableWidget(Widget child, UselessFactState state) {
    return ProviderScope(
      overrides: [
        uselessFactProvider.overrideWith((ref) {
          final controller = MockUselessFactController();
          when(() => controller.state).thenReturn(state);
          when(() => controller.getAFact()).thenAnswer((_) async {});
          return controller;
        }),
      ],
      child: MaterialApp(home: child),
    );
  }

  testWidgets("Shows initial text", (tester) async {
    // when(() => mockController.state).thenReturn(initial);

    await tester.pumpWidget(
      buildTestableWidget(UselessFactPresentor(), initial),
    );

    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets("Shows loading when loading", (tester) async {
    // when(() => mockController.state).thenReturn(loading);

    await tester.pumpWidget(
      buildTestableWidget(UselessFactPresentor(), loading),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("Shows fact when loaded", (tester) async {
    // when(() => mockController.state).thenReturn(success);

    await tester.pumpWidget(
      buildTestableWidget(UselessFactPresentor(), success),
    );

    expect(find.text("Don't be useless!"), findsOneWidget);
    expect(find.byType(UselessFactCard), findsOneWidget);
  });

  testWidgets("Shows error when failed", (tester) async {
    // when(() => mockController.state).thenReturn(failure);

    await tester.pumpWidget(
      buildTestableWidget(UselessFactPresentor(), failure),
    );

    expect(find.textContaining("testfailure"), findsOneWidget);
  });

  testWidgets("Fetch button triggers fetch", (tester) async {
    when(() => mockController.state).thenReturn(initial);
    when(() => mockController.getAFact()).thenAnswer((_) async {});

    await tester.pumpWidget(
      buildTestableWidget(UselessFactPresentor(), initial),
    );

    final button = find.byType(ElevatedButton);
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pump();

    verify(() => mockController.getAFact()).called(1);
  });
}
