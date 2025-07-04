import '../repository/useless_fact_repository.dart';

class GetUselessFact {
  final UselessFactRepository _uselessFactRepository;
  GetUselessFact(this._uselessFactRepository);
  call() async {
    return await _uselessFactRepository.getUselessFact();
  }
}
