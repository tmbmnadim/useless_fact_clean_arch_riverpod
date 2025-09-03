import 'package:get/get.dart';
import 'package:mood_log_tests/features/chat/domain/entity/message.dart';
import 'package:mood_log_tests/features/chat/domain/usecase/get_messages.dart';
import 'package:mood_log_tests/features/chat/domain/usecase/get_stream.dart';
import 'package:mood_log_tests/features/chat/domain/usecase/send_message.dart';

class MessagesController extends GetxController {
  final GetMessages _getMessagesUC;
  final GetStreamUC _getStream;
  final SendMessage _sendMessage;
  MessagesController(this._getMessagesUC, this._getStream, this._sendMessage) {
    _initialize();
  }

  final RxList<Message> _messages = <Message>[].obs;
  List<Message> get messages => _messages;

  Future<void> sendMessage(Message msg) async {
    await _sendMessage(msg);
    // _messages.add(msg);
  }

  Future<void> _initialize() async {
    await _getMessages();
    final stream = _getStream();
    stream.listen((msg) {
      _messages.add(msg);
    });
  }

  Future<void> _getMessages() async {
    final data = await _getMessagesUC();
    _messages.addAll(data);
  }
}
