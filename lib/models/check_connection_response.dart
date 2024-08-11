import 'dart:convert';

import 'package:hotspot_chat/models/user.dart';

class CheckConnectionResponse {
  final bool status;
  final User user;
  final String endpoint;

  CheckConnectionResponse(
      {required this.status, required this.user, required this.endpoint});

  toJson() {
    return {'status': status, 'user': user.toJson(), 'endpoint': endpoint};
  }

  CheckConnectionResponse.fromJson(Map<String, dynamic> map)
      : status = map['status'],
        user = User.fromJson(map['user']),
        endpoint = map['endpoint'];

  String toRawJson() {
    return json.encode(toJson());
  }

  factory CheckConnectionResponse.fromRawJson(String source) =>
      CheckConnectionResponse.fromJson(json.decode(source));
}
