import 'package:mood_log_tests/features/chat/domain/entity/message.dart';
import 'package:mood_log_tests/features/chat/domain/repository/message_repository.dart';

class GetMessages {
  final MessageRepository _repository;
  GetMessages(this._repository);
  Future<List<Message>> call(int user1, int user2) {
    return _repository.getMessages(user1, user2);
  }
}
