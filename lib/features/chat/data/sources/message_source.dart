import 'dart:convert';

import 'package:mood_log_tests/core/util/message_socket.dart';
import 'package:mood_log_tests/features/chat/data/models/message.dart';

class MessageSource {
  final MessageSocket<MessageModel> _messageSocket;
  MessageSource(this._messageSocket) {
    // Ran a local server with fast api
    _messageSocket.initialize("");
  }

  Future<List<MessageModel>> getMessages() async {
    final data = [
      {
        'text': "Hey! How are you doing today?",
        'is_me': false,
        'timestamp': _getTime(30),
      },
      {
        'text':
            "I'm doing great! Just working on some Flutter projects. How about you?",
        'is_me': true,
        'timestamp': _getTime(28),
      },
      {
        'text': "That sounds awesome! I'd love to see what you're building.",
        'is_me': false,
        'timestamp': _getTime(25),
      },
      {
        'text':
            "Sure! I'm working on a chat app with a nice brown theme. Want to check it out?",
        'is_me': true,
        'timestamp': _getTime(20),
      },
    ];

    return data.map((e) => MessageModel.fromJson(e)).toList();
  }

  Future<void> sendMessage(MessageModel message) async {
    await _messageSocket.sendMessage(jsonEncode(message.toJson()));
  }

  Stream<MessageModel> getStream() {
    final stream = _messageSocket.getMessageStream((e) {
      if (e is String) {
        return MessageModel(text: e, isMe: false, timestamp: DateTime.now());
      } else {
        return null;
      }
    });
    return stream.map((e) {
      if (e == null) {
        return MessageModel(
          text: "FAILED FETCHING",
          isMe: false,
          timestamp: DateTime.now(),
        );
      }
      return MessageModel.fromJson(jsonDecode(e));
    });
  }

  String _getTime(int minutes) {
    return DateTime.now()
        .subtract(Duration(minutes: minutes))
        .toIso8601String();
  }
}
