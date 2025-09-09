import '../entity/message.dart';

abstract class MessageRepository {
  Future<List<Message>> getMessages(int user1, int user2);

  Stream<Message> getStream();

  Future<void> sendMessage(Message message);
}
