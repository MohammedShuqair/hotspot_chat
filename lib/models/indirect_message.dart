import 'dart:convert';

import 'package:hotspot_chat/models/message.dart';
import 'package:hotspot_chat/models/user.dart';

class IndirectMessage {
  String? endpoint;
  Message? message;
  User? thirdParty;

  IndirectMessage({
    this.endpoint,
    this.message,
    this.thirdParty,
  });

  factory IndirectMessage.fromRawJson(String str) =>
      IndirectMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IndirectMessage.fromJson(Map<String, dynamic> json) =>
      IndirectMessage(
        endpoint: json["endpoint"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        thirdParty: json["third_party"] == null
            ? null
            : User.fromJson(json["third_party"]),
      );

  Map<String, dynamic> toJson() => {
        "endpoint": endpoint,
        "message": message?.toJson(),
        "third_party": thirdParty?.toJson(),
      };
}
