import '../../../../core/util/datastate.dart';
import '../entities/useless_fact_entity.dart';

abstract class UselessFactRepository {
  Future<DataState<UselessFact>> getUselessFact();
}
