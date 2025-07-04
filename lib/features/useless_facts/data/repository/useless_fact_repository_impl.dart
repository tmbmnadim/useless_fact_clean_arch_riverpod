import 'package:dio/dio.dart';
import 'package:mood_log_tests/features/useless_facts/data/models/useless_fact_model.dart';
import 'package:mood_log_tests/features/useless_facts/data/source/useless_fact_source.dart';

import '../../../../core/util/datastate.dart';
import '../../domain/repository/useless_fact_repository.dart';

class UselessFactRepositoryImpl extends UselessFactRepository {
  final UselessFactSource _uselessFactSource;
  UselessFactRepositoryImpl(this._uselessFactSource);

  @override
  Future<DataState<UselessFactModel>> getUselessFact() async {
    try {
      final fact = await _uselessFactSource.getUselessFact();

      return DataSuccess(fact);
    } on DioException catch (e) {
      return DataFailed(
        "${e.response?.statusCode}: ${e.response?.statusMessage}",
      );
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
