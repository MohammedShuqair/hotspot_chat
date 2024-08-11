import 'dart:convert';

import 'package:hotspot_chat/models/user.dart';

class Chat {
  final String? id;
  final List<User> userList;

  Chat({
    this.id,
    this.userList = const [],
  });

  // Convert a Chat into a Map. The keys must correspond to the table columns.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_list': jsonEncode(userList.map((e) => e.toRawJson()).toList()),
    };
  }

  // Convert a Map into a Chat object.
  factory Chat.fromJson(Map<String, dynamic> map) {
    List list = map['user_list'];
    return Chat(
      id: map['id'],
      userList: list.map((e) => User.fromRawJson(e)).toList(),
    );
  }

  // Convert a Chat object into a JSON string.
  String toRawJson() => json.encode(toJson());

  // Convert a JSON string into a Chat object.
  factory Chat.fromRawJson(String source) => Chat.fromJson(json.decode(source));
}
