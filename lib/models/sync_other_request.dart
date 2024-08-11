import 'dart:convert';

import 'package:hotspot_chat/models/user.dart';
import 'package:hotspot_chat/services/network/udp_endpoints/udp_endpoint.dart';

class SyncOtherRequest {
  final String endpoint;
  User? user;

  SyncOtherRequest({
    this.endpoint = UDPEndpoint.syncOtherRequest,
    this.user,
  });

  factory SyncOtherRequest.fromRawJson(String str) =>
      SyncOtherRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SyncOtherRequest.fromJson(Map<String, dynamic> json) =>
      SyncOtherRequest(
        endpoint: json["endpoint"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "endpoint": endpoint,
        "user": user?.toJson(),
      };
}
