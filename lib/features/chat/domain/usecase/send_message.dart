import 'package:mood_log_tests/features/chat/domain/entity/message.dart';
import 'package:mood_log_tests/features/chat/domain/repository/message_repository.dart';

class SendMessage {
  final MessageRepository _repository;
  SendMessage(this._repository);
  Future<void> call(Message message) {
    return _repository.sendMessage(message);
  }
}
