import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/features/useless_facts/domain/entities/useless_fact_entity.dart';
import 'package:mood_log_tests/features/useless_facts/domain/repository/useless_fact_repository.dart';
import 'package:mood_log_tests/features/useless_facts/domain/usecase/useless_fact_usecase.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/controller/useless_fact_controller.dart';
import 'package:mood_log_tests/features/useless_facts/useless_fact_injector.dart';

class MockFactRepository extends Mock implements UselessFactRepository {}

void main() {
  late MockFactRepository mockFactRepository;
  late GetUselessFact getUselessFactUC;
  late UselessFactController controller;

  final testFact = UselessFact(id: "ABC", text: "Don't be useless!");
  final testFactDS = DataSuccess<UselessFact>(testFact);
  final testFactDSFailure = DataFailed<UselessFact>("Failed");

  setUp(() {
    mockFactRepository = MockFactRepository();
    getUselessFactUC = GetUselessFact(mockFactRepository);
    final container = ProviderContainer(
      overrides: [uselessFactRepository.overrideWithValue(mockFactRepository)],
    );
    controller = container.read(uselessFactProvider.notifier);
  });

  test("usecase returns facts from repository", () async {
    when(() {
      return mockFactRepository.getUselessFact();
    }).thenAnswer((_) async {
      return testFactDS;
    });

    final DataState<UselessFact> result = await getUselessFactUC.call();

    expect(result.getData(), testFactDS.getData());
  });

  test("controller updates state on succesful load", () async {
    when(() {
      return mockFactRepository.getUselessFact();
    }).thenAnswer((_) async {
      return testFactDS;
    });

    await controller.getAFact();

    expect(controller.state.isFailure, false);
    expect(controller.state.uselessFact, testFact);
  });

  test("controller updates state on failure", () async {
    when(() {
      return mockFactRepository.getUselessFact();
    }).thenAnswer((_) async {
      return testFactDSFailure;
    });

    await controller.getAFact();

    expect(controller.state.isFailure, true);
  });
}
