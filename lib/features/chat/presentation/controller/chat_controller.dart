import 'package:get/get.dart';
import 'package:mood_log_tests/features/chat/domain/entity/message.dart';
import 'package:mood_log_tests/features/chat/domain/usecase/get_messages.dart';
import 'package:mood_log_tests/features/chat/domain/usecase/get_stream.dart';
import 'package:mood_log_tests/features/chat/domain/usecase/send_message.dart';

class MessagesController extends GetxController {
  final GetMessages _getMessagesUC;
  final GetStreamUC _getStream;
  final SendMessage _sendMessage;
  MessagesController(this._getMessagesUC, this._getStream, this._sendMessage);

  final RxList<Message> _messages = <Message>[].obs;
  List<Message> get messages => _messages;
  final RxBool _firstTime = false.obs;
  bool get showDialog => _firstTime.value;
  set showDialog(bool value) => _firstTime.value = value;

  Future<void> sendMessage(Message msg) async {
    await _sendMessage(msg);
    // _messages.add(msg);
  }

  Future<void> initialize(int user1, int user2) async {
    await _getMessages(user1, user2);
    await Future.delayed(Duration(milliseconds: 200));
    final stream = _getStream();
    stream.listen((msg) {
      print(msg);
      _messages.add(msg);
    });
  }

  Future<void> _getMessages(int user1, int user2) async {
    final data = await _getMessagesUC(user1, user2);
    _messages.addAll(data);
  }
}
