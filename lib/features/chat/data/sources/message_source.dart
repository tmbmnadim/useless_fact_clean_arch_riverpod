import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mood_log_tests/core/util/message_socket.dart';
import 'package:mood_log_tests/features/chat/data/models/message.dart';

class MessageSource {
  final MessageSocket<MessageModel> _messageSocket;
  MessageSource(this._messageSocket) {
    _messageSocket.initialize("ws://$_base/ws");
  }
  final String? _base = dotenv.env['server_link'];

  Future<List<MessageModel>> getMessages() async {
    final data = [
      {
        'text': "Hey! How are you doing today?",
        'from': "a",
        'to': "b",
        'timestamp': _getTime(30),
      },
      {
        'text':
            "I'm doing great! Just working on some Flutter projects. How about you?",
        'from': "b",
        'to': "a",
        'timestamp': _getTime(28),
      },
      {
        'text': "That sounds awesome! I'd love to see what you're building.",
        'from': "a",
        'to': "b",
        'timestamp': _getTime(25),
      },
      {
        'text':
            "Sure! I'm working on a chat app with a nice brown theme. Want to check it out?",
        'from': "b",
        'to': "a",
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
        return MessageModel.fromJson(jsonDecode(e));
      } else {
        return null;
      }
    });
    return stream.map((e) {
      if (e == null) {
        return MessageModel(
          text: "FAILED FETCHING",
          from: 999,
          to: 9999,
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
