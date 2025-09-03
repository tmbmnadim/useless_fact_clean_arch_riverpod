import 'package:mood_log_tests/features/chat/domain/entity/message.dart';
import 'package:mood_log_tests/features/chat/domain/repository/message_repository.dart';

class GetMessages {
  final MessageRepository _repository;
  GetMessages(this._repository);
  Future<List<Message>> call() {
    return _repository.getMessages();
  }
}
