import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mood_log_tests/core/util/datastate.dart';
import 'package:mood_log_tests/features/useless_facts/data/models/useless_fact_model.dart';
import 'package:mood_log_tests/features/useless_facts/data/repository/useless_fact_repository_impl.dart';
import 'package:mood_log_tests/features/useless_facts/domain/entities/useless_fact_entity.dart';
import 'package:mood_log_tests/features/useless_facts/domain/usecase/useless_fact_usecase.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/controller/useless_fact_controller.dart';

class MockFactRepository extends Mock implements UselessFactRepositoryImpl {}

void main() {
  late MockFactRepository mockFactRepository;
  late GetUselessFact getUselessFactUC;
  late UselessFactController controller;

  final testFact = UselessFactModel(id: "ABC", text: "Don't be useless!");
  final testFactDS = DataSuccess<UselessFactModel>(testFact);
  final testFactDSFailure = DataFailed<UselessFactModel>("Failed");

  setUp(() {
    mockFactRepository = MockFactRepository();
    getUselessFactUC = GetUselessFact(mockFactRepository);
    controller = UselessFactController(getUselessFactUC);
  });

  test("usecase returns facts from repository", () async {
    when(() {
      return mockFactRepository.getUselessFact();
    }).thenAnswer((_) async {
      return testFactDS;
    });

    final DataState<UselessFact> result = await getUselessFactUC.call();

    expect(result.data, testFactDS.data);
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
