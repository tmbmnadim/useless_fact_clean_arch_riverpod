import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mood_log_tests/core/util/message_socket.dart';
import 'package:mood_log_tests/features/chat/data/models/message.dart';

class MessageSource {
  final MessageSocket<MessageModel> _messageSocket;
  MessageSource(this._messageSocket);
  final String? _base = dotenv.env['server_link'];

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

  Future<List<MessageModel>> getMessages(int user1, int user2) async {
    await _messageSocket.close();
    _messageSocket.initialize("ws://$_base/ws/$user1/$user2");
    List<MessageModel> output = [];
    Uri? baseUri = Uri.tryParse("http://$_base/messages/between/$user1/$user2");
    if (baseUri == null) {
      throw "Server url is empty";
    }

    final response = await http.get(baseUri);
    final data = response.body;
    if (response.statusCode != 200) {
      throw response.reasonPhrase ?? "Something went wrong!";
    }
    List rawMsgs = jsonDecode(data);

    for (var msg in rawMsgs) {
      if (msg is Map<String, dynamic>) {
        output.add(MessageModel.fromJson(msg));
      }
    }

    return output;
  }

  Future<void> sendMessage(MessageModel message) async {
    print("");
    print(message.toString());
    print("");
    await _messageSocket.sendMessage(jsonEncode(message.toJson()));
    Uri? baseUri = Uri.tryParse("http://$_base/messages/");
    if (baseUri == null) {
      throw "Server url is empty";
    }

    final response = await http.post(
      baseUri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(message.toJson()),
    );
    final data = response.body;
    if (response.statusCode != 200) {
      throw response.reasonPhrase ?? "Something went wrong!";
    }
  }
}
