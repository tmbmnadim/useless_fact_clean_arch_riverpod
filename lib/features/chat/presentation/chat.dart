import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_log_tests/config/theme/app_theme.dart';
import 'package:mood_log_tests/features/chat/domain/entity/message.dart';
import 'package:mood_log_tests/features/chat/presentation/controller/chat_controller.dart';
import 'package:mood_log_tests/features/chat/presentation/widgets/text_field.dart';
import 'package:mood_log_tests/features/user/domain/entity/user.dart';
import 'package:mood_log_tests/features/user/presentation/controller/user_controller.dart';
import 'package:mood_log_tests/features/user/presentation/user.dart';
import 'package:mood_log_tests/features/user/presentation/widgets/user_dialog.dart';

import 'widgets/message_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  void _showEditUserDialog(
    BuildContext context,
    UserController userCtrl,
    MessagesController chatCtrl,
  ) async {
    await userCtrl.initiateUser(User());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<int>(
        context: context,
        builder:
            (context) => UserDialog(
              title: 'Edit User ID',
              initial: '',
              onSubmit: (data) {
                userCtrl.initiateUser(User(id: int.tryParse(data)));
              },
              onCancel: () {
                _createUserDialog(context, (data) {
                  userCtrl.initiateUser(User(name: data));
                });
              },
            ),
      );
    });
  }

  Future<void> _createUserDialog(
    BuildContext context,
    Function(String) onSubmit,
  ) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder:
            (context) => UserDialog(
              title: 'Edit User Name',
              initial: '',
              onSubmit: onSubmit,
              onCancel: () {},
            ),
      );
    });
  }

  void _sendMessage({
    required TextEditingController msgCtrl,
    required ScrollController scrlCtrl,
    required UserController usrCtrl,
  }) {
    MessagesController chatCtrl = Get.find();
    if (msgCtrl.text.trim().isEmpty) return;

    chatCtrl.sendMessage(
      Message(
        text: msgCtrl.text.trim(),
        from: usrCtrl.user?.id ?? 999,
        to: usrCtrl.otherUser,
        timestamp: DateTime.now(),
      ),
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
    final chatCtrl = Get.find<MessagesController>();
    final userCtrl = Get.find<UserController>();
    final TextEditingController messageController = TextEditingController();
    final TextEditingController searchCtrl = TextEditingController();
    final ScrollController scrollController = ScrollController();

    _showEditUserDialog(context, userCtrl, chatCtrl);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8D6E63),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                final usr = userCtrl.user;
                if (usr != null && usr.id != null && usr.name != null) {
                  Get.to(UserPage());
                } else {
                  _createUserDialog(context, (data) {
                    userCtrl.initiateUser(User(name: data));
                  });
                }
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    userCtrl.user?.name ?? "Useful User",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
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
          CustomTextField(
            controller: searchCtrl,
            hintText: "Enter User id to start a conversation",
            onSubmitted: (_) {},
            buttonIcon: Icons.search,
            onButton: () {
              final user1 = userCtrl.user?.id;
              final user2 = int.tryParse(searchCtrl.text);
              if (user1 != null && user2 != null) {
                chatCtrl.initialize(user1, user2);
                userCtrl.otherUser = user2;
              }
            },
            onPrefix: () {},
          ),
          // Messages list
          Expanded(
            child: Obx(() {
              if (chatCtrl.messages.isEmpty) {
                return SizedBox();
              }
              if (chatCtrl.messages.last.from == userCtrl.otherUser) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
              }
              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: chatCtrl.messages.length,
                itemBuilder: (context, index) {
                  final message = chatCtrl.messages[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: MessageBubble(message: message, user: userCtrl.user),
                  );
                },
              );
            }),
          ),

          // Message input
          CustomTextField(
            controller: messageController,
            hintText: "Type a message...",
            onSubmitted:
                (_) => _sendMessage(
                  msgCtrl: messageController,
                  scrlCtrl: scrollController,
                  usrCtrl: userCtrl,
                ),
            buttonIcon: Icons.send,
            onButton:
                () => _sendMessage(
                  msgCtrl: messageController,
                  scrlCtrl: scrollController,
                  usrCtrl: userCtrl,
                ),
            prefixIcon: Icons.attach_file,
            onPrefix: () {},
          ),
        ],
      ),
    );
  }
}
