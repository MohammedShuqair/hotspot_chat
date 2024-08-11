import 'dart:convert';

class Message {
  final String? endpoint;
  final DateTime? sendAt;
  final String? content;
  final String? chatId;
  final String? senderId;
  final String? receiverId;

  Message({
    this.endpoint,
    this.sendAt,
    this.content,
    this.chatId,
    this.senderId,
    this.receiverId,
  });

  bool currentIsSender(String currentId) {
    return senderId == currentId;
  }

  // Convert a Message into a Map. The keys must correspond to the table columns.
  Map<String, dynamic> toJson({bool withEndpoint = true}) {
    var map = {
      'timestamp': sendAt?.millisecondsSinceEpoch,
      'content': content,
      'chat_id': chatId,
      'sender_id': senderId,
      'receiver_id': receiverId,
    };
    if (withEndpoint) {
      map.addAll({'endpoint': endpoint});
    }
    return map;
  }

  // Convert a Map into a Message object.
  factory Message.fromJson(Map<String, dynamic> map) {
    int? timestamp = map['timestamp'];
    return Message(
      endpoint: map['endpoint'],
      sendAt: timestamp == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(timestamp),
      content: map['content'],
      chatId: map['chat_id'],
      senderId: map['sender_id'],
      receiverId: map['receiver_id'],
    );
  }

  // Convert a Message object into a JSON string.
  String toRawJson({bool withEndpoint = true}) =>
      json.encode(toJson(withEndpoint: withEndpoint));

  // Convert a JSON string into a Message object.
  factory Message.fromRawJson(String source) =>
      Message.fromJson(json.decode(source));
}
