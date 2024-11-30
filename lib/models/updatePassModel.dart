

import 'dart:convert';

UpdatePassFromApp updatePassFromAppFromJson(String str) =>
    UpdatePassFromApp.fromJson(json.decode(str));

String updatePassFromAppToJson(UpdatePassFromApp data) =>
    json.encode(data.toJson());

class UpdatePassFromApp {
  UpdatePassFromApp({
    required this.code,
    required this.status,
    required this.msg,
  });

  int code;
  bool status;
  String msg;

  factory UpdatePassFromApp.fromJson(Map<String, dynamic> json) =>
      UpdatePassFromApp(
        code: json["code"] == null ? null : json["code"],
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "msg": msg == null ? null : msg,
  };
}
