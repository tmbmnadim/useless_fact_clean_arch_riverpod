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

void initChatDependency() {
  Get.put<MessageSocket<MessageModel>>(MessageSocket<MessageModel>());
  Get.lazyPut<MessageSource>(() => MessageSource(Get.find()));
  Get.lazyPut<MessageRepository>(() => MessageRepositoryImpl(Get.find()));
  Get.lazyPut<GetMessages>(() => GetMessages(Get.find()));
  Get.lazyPut<GetStreamUC>(() => GetStreamUC(Get.find()));
  Get.lazyPut<SendMessage>(() => SendMessage(Get.find()));
  Get.put<MessagesController>(
    MessagesController(Get.find(), Get.find(), Get.find()),
  );
}
