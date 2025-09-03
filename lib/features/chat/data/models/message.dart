import 'package:mood_log_tests/features/chat/domain/entity/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.text, // String
    required super.isMe, // bool
    required super.timestamp, // Datetime --> toIso8601String
  });

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "is_me": isMe,
      "timestamp": timestamp.toIso8601String(),
    };
  }

  Message toEntity() {
    return Message(text: text, isMe: isMe, timestamp: timestamp);
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json["text"],
      isMe: json["is_me"],
      timestamp: DateTime.parse(json["timestamp"]),
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      text: message.text,
      isMe: message.isMe,
      timestamp: message.timestamp,
    );
  }
}
