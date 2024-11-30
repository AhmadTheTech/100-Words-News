
import 'dart:convert';

MessageResponse messageResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) => json.encode(data.toJson());

class MessageResponse {
  MessageResponse({
    required this.status,
    required this.response,
  });

  bool status;
  String response;

  factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
    status: json["status"],
    response: json["response"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response": response,
  };
}
