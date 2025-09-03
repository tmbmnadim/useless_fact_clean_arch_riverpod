import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_log_tests/config/theme/app_theme.dart';
import 'package:mood_log_tests/features/chat/chat_dependencies.dart';
import 'package:mood_log_tests/features/chat/domain/entity/message.dart';
import 'package:mood_log_tests/features/chat/presentation/controller/chat_controller.dart';

import 'widgets/message_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  void _sendMessage({
    required TextEditingController msgCtrl,
    required ScrollController scrlCtrl,
  }) {
    MessagesController chatCtrl = Get.find();
    if (msgCtrl.text.trim().isEmpty) return;

    chatCtrl.sendMessage(
      Message(text: msgCtrl.text.trim(), isMe: true, timestamp: DateTime.now()),
    );

    msgCtrl.clear();

    // Auto scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrlCtrl.animateTo(
        scrlCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    initChatDependencies();
    final theme = Theme.of(context);
    final chatPalette = theme.extension<ChatPalette>();
    final TextEditingController messageController = TextEditingController();
    final ScrollController scrollController = ScrollController();
    final MessagesController chatCtrl = Get.find();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0), // Light cream background
      appBar: AppBar(
        backgroundColor: const Color(0xFF8D6E63), // Medium brown
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alex Johnson',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Online',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.call_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
        elevation: 2,
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: Obx(() {
              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: chatCtrl.messages.length,
                itemBuilder: (context, index) {
                  final message = chatCtrl.messages[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: MessageBubble(message: message),
                  );
                },
              );
            }),
          ),

          // Message input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(11),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Attach button
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    color: const Color(0xFF8D6E63),
                    onPressed: () {},
                  ),

                  // Message input field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F0),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFFD7CCC8),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        maxLines: null,
                        onSubmitted:
                            (_) => _sendMessage(
                              msgCtrl: messageController,
                              scrlCtrl: scrollController,
                            ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Send button
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF8D6E63),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed:
                          () => _sendMessage(
                            msgCtrl: messageController,
                            scrlCtrl: scrollController,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
