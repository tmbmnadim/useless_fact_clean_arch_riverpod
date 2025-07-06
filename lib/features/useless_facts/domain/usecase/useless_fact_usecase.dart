import '../../../../core/util/datastate.dart';
import '../../../../core/util/usecase_bp.dart';
import '../entities/useless_fact_entity.dart';
import '../repository/useless_fact_repository.dart';

class GetUselessFact extends Usecase<DataState<UselessFact>, void> {
  final UselessFactRepository _uselessFactRepository;

  GetUselessFact(this._uselessFactRepository);

  @override
  Future<DataState<UselessFact>> call([noparam]) async {
    return await _uselessFactRepository.getUselessFact();
  }
}
