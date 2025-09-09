import 'package:mood_log_tests/features/chat/data/models/message.dart';
import 'package:mood_log_tests/features/chat/data/sources/message_source.dart';
import 'package:mood_log_tests/features/chat/domain/entity/message.dart';
import 'package:mood_log_tests/features/chat/domain/repository/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageSource _source;
  MessageRepositoryImpl(this._source);

  @override
  Future<List<Message>> getMessages(int user1, int user2) async {
    final messages = await _source.getMessages(user1, user2);
    return messages.map((e) => e.toEntity()).toList();
  }

  @override
  Stream<Message> getStream() {
    final stream = _source.getStream();
    return stream.map((e) => e.toEntity());
  }

  @override
  Future<void> sendMessage(Message message) async {
    _source.sendMessage(MessageModel.fromEntity(message));
  }
}
