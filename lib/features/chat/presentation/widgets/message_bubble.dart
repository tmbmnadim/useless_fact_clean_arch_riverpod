import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_log_tests/features/chat/domain/entity/message.dart';
import 'package:mood_log_tests/features/user/domain/entity/user.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final User? user;

  const MessageBubble({super.key, required this.message, required this.user});

  @override
  Widget build(BuildContext context) {
    bool isMe = message.isMe(user?.id);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe && user != null) ...[
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFD7CCC8),
            child: Icon(Icons.person, size: 18, color: Color(0xFF8D6E63)),
          ),
          const SizedBox(width: 8),
        ],

        Flexible(
          child: Column(
            crossAxisAlignment:
                user == null
                    ? CrossAxisAlignment.center
                    : isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color:
                      isMe
                          ? const Color(0xFF8D6E63) // Medium brown for sent
                          : const Color(0xFFEFEBE9), // Light brown for received
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: Radius.circular(isMe ? 20 : 4),
                    bottomRight: Radius.circular(isMe ? 4 : 20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  message.text ?? "N/A",
                  style: TextStyle(
                    color: isMe ? Colors.white : const Color(0xFF3E2723),
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // Timestamp
              Text(
                DateFormat("hh:mm").format(message.timestamp ?? DateTime.now()),
                style: TextStyle(color: Colors.grey[600], fontSize: 11),
              ),
            ],
          ),
        ),

        if (isMe && user != null) ...[
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF8D6E63),
            child: Icon(Icons.person, size: 18, color: Colors.white),
          ),
        ],
      ],
    );
  }
}
