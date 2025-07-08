import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_log_tests/features/useless_facts/data/source/useless_fact_source.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/controller/useless_fact_controller.dart';

import 'data/repository/useless_fact_repository_impl.dart';
import 'domain/repository/useless_fact_repository.dart';
import 'domain/usecase/useless_fact_usecase.dart';

final uselessFactSource = Provider<UselessFactSource>((ref) {
  return UselessFactSource();
});

final uselessFactRepository = Provider<UselessFactRepository>((ref) {
  final source = ref.read(uselessFactSource);
  return UselessFactRepositoryImpl(source);
});

final getUselessFactUC = Provider<GetUselessFact>((ref) {
  final repo = ref.read(uselessFactRepository);
  return GetUselessFact(repo);
});

final uselessFactProvider =
    NotifierProvider<UselessFactController, UselessFactState>(() {
      return UselessFactController();
    });
