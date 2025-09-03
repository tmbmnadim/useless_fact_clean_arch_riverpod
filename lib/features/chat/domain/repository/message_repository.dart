import '../entity/message.dart';

abstract class MessageRepository {
  Future<List<Message>> getMessages();

  Stream<Message> getStream();

  Future<void> sendMessage(Message message);
}
