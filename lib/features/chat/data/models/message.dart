import 'package:mood_log_tests/features/chat/domain/entity/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.text,
    required super.from,
    required super.to,
    required super.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "from": from,
      "to": to,
      "timestamp": timestamp?.toIso8601String(),
    };
  }

  Message toEntity() {
    return Message(text: text, from: from, to: to, timestamp: timestamp);
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json["text"],
      from: int.tryParse(json["from"]),
      to: int.tryParse(json["to"]),
      timestamp: DateTime.parse(json["timestamp"]),
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      text: message.text,
      from: message.from,
      to: message.to,
      timestamp: message.timestamp,
    );
  }
}
