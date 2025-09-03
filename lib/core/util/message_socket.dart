import 'package:web_socket_channel/web_socket_channel.dart';

class MessageSocket<T> {
  MessageSocket._();

  static MessageSocket<T> _instance<T>() => MessageSocket<T>._();

  factory MessageSocket() {
    return _instance<T>();
  }
  late WebSocketChannel _channel;

  void initialize(String server) {
    _channel = WebSocketChannel.connect(Uri.parse(server));
  }

  Stream<String?> getMessageStream(T? Function(dynamic) dynamicToT) {
    return _channel.stream.map((e) {
      if (e is String) {
        return e;
      } else {
        return null;
      }
    });
  }

  Future<void> sendMessage(String message) async {
    _channel.sink.add(message);
  }

  Future<void> close() async {
    await _channel.sink.close();
  }
}
