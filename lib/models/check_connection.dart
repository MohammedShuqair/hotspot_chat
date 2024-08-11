import 'dart:convert';

import 'package:hotspot_chat/models/user.dart';

class CheckConnectionRequest {
  String? endpoint;
  String? sendAt;
  User? sender;

  CheckConnectionRequest({
    this.endpoint,
    this.sendAt,
    this.sender,
  });

  factory CheckConnectionRequest.fromRawJson(String str) =>
      CheckConnectionRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckConnectionRequest.fromJson(Map<String, dynamic> json) =>
      CheckConnectionRequest(
        endpoint: json["endpoint"],
        sendAt: json["send_at"],
        sender: json["sender"] == null ? null : User.fromJson(json["sender"]),
      );

  Map<String, dynamic> toJson() => {
        "endpoint": endpoint,
        "send_at": sendAt,
        "sender": sender?.toJson(),
      };
}
