// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int? id;
  final String? text;
  final int? from;
  final int? to;
  final DateTime? timestamp;

  const Message({
    this.id,
    required this.text,
    required this.from,
    required this.to,
    required this.timestamp,
  });

  bool isMe(int? user) => from == user;

  @override
  String toString() {
    return "Message(ID:$id, text:$text, $from=>$to at $timestamp)";
  }

  @override
  List<Object?> get props => [id];
}
