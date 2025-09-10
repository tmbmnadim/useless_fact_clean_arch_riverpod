import 'package:mood_log_tests/features/chat/domain/entity/message.dart';

class MessageModel extends Message {
  const MessageModel({
    super.id,
    required super.text,
    required super.from,
    required super.to,
    required super.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      "text": text,
      "from_user_id": from,
      "to_user_id": to,
      "timestamp": timestamp?.toIso8601String(),
    };
  }

  Message toEntity() {
    return Message(
      id: id,
      text: text,
      from: from,
      to: to,
      timestamp: timestamp,
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json["id"],
      text: json["text"],
      from: json["from_user_id"],
      to: json["to_user_id"],
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      text: message.text,
      from: message.from,
      to: message.to,
      timestamp: message.timestamp,
    );
  }
}
