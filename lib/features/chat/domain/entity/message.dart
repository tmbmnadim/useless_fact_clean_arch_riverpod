class Message {
  final String? text;
  final int? from;
  final int? to;
  final DateTime? timestamp;

  Message({
    required this.text,
    required this.from,
    required this.to,
    required this.timestamp,
  });

  bool isMe(int? user) => from == user;
}
