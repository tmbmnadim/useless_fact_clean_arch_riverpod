import 'package:mood_log_tests/features/chat/domain/entity/message.dart';
import 'package:mood_log_tests/features/chat/domain/repository/message_repository.dart';

class GetStreamUC {
  final MessageRepository _repository;
  GetStreamUC(this._repository);
  Stream<Message> call() {
    return _repository.getStream();
  }
}
