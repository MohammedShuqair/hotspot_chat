import 'dart:convert';

class User {
  String? ip;
  String? deviceIdentifier;
  String? name;

  void updateIp(String? newIp) {
    ip = newIp;
  }

  User({
    this.ip,
    this.deviceIdentifier,
    this.name,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        ip: json["ip"],
        deviceIdentifier: json["device_identifier"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "device_identifier": deviceIdentifier,
        "name": name,
      };
}
