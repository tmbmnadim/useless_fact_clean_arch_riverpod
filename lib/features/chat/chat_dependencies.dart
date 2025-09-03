import 'package:get/get.dart';
import 'package:mood_log_tests/core/util/message_socket.dart';
import 'package:mood_log_tests/features/chat/data/models/message.dart';
import 'package:mood_log_tests/features/chat/data/repository/message_repository.dart';
import 'package:mood_log_tests/features/chat/data/sources/message_source.dart';
import 'package:mood_log_tests/features/chat/domain/repository/message_repository.dart';
import 'package:mood_log_tests/features/chat/domain/usecase/get_messages.dart';
import 'package:mood_log_tests/features/chat/domain/usecase/get_stream.dart';
import 'package:mood_log_tests/features/chat/domain/usecase/send_message.dart';
import 'package:mood_log_tests/features/chat/presentation/controller/chat_controller.dart';

void initChatDependencies() {
  final msgSocket = Get.put(MessageSocket<MessageModel>());
  final msgSource = Get.put(MessageSource(msgSocket));
  final msgRepo = Get.put<MessageRepository>(MessageRepositoryImpl(msgSource));
  final getMsgUC = Get.put(GetMessages(msgRepo));
  final getStreamUC = Get.put(GetStreamUC(msgRepo));
  final sendMsgUC = Get.put(SendMessage(msgRepo));
  final msgCtrl = Get.put(MessagesController(getMsgUC, getStreamUC, sendMsgUC));
}
