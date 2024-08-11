import 'dart:convert';

import 'package:hotspot_chat/models/message.dart';
import 'package:hotspot_chat/services/network/udp_endpoints/udp_endpoint.dart';

class SyncOtherResponse {
  String endpoint;
  List<Message>? message;

  SyncOtherResponse({
    this.endpoint = UDPEndpoint.syncOtherResponse,
    this.message,
  });

  factory SyncOtherResponse.fromRawJson(String str) =>
      SyncOtherResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SyncOtherResponse.fromJson(Map<String, dynamic> json) =>
      SyncOtherResponse(
        endpoint: json["endpoint"],
        message: json["message"] == null
            ? []
            : List<Message>.from(
                json["message"]!.map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "endpoint": endpoint,
        "message": message == null
            ? []
            : List<dynamic>.from(
                message!.map((x) => x.toJson(withEndpoint: false))),
      };
}
