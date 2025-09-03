import 'package:flutter/material.dart';
import 'package:mood_log_tests/features/chat/domain/entity/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isMe) ...[
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
                message.isMe
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
                      message.isMe
                          ? const Color(0xFF8D6E63) // Medium brown for sent
                          : const Color(0xFFEFEBE9), // Light brown for received
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: Radius.circular(message.isMe ? 20 : 4),
                    bottomRight: Radius.circular(message.isMe ? 4 : 20),
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
                  message.text,
                  style: TextStyle(
                    color:
                        message.isMe ? Colors.white : const Color(0xFF3E2723),
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // Timestamp
              Text(
                _formatTime(message.timestamp),
                style: TextStyle(color: Colors.grey[600], fontSize: 11),
              ),
            ],
          ),
        ),

        if (message.isMe) ...[
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

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
